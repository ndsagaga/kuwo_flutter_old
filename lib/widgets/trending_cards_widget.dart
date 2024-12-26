import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuwo/widgets/card_list_item_widget.dart';
import '../models/card_model.dart';
import '../services/data_service.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TrendingCardsWidget extends StatelessWidget {
  final Function(String) onCardTapped;
  const TrendingCardsWidget({super.key, required this.onCardTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(children: [
            const Icon(
              Icons.trending_up,
              color: Color.fromARGB(255, 44, 44, 44),
              size: 25,
            ),
            const SizedBox(width: 5),
            AutoSizeText(
              "Trending",
              maxLines: 1,
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                  color: const Color.fromARGB(255, 44, 44, 44)),
            ),
          ]),
          const Divider(),
          FutureBuilder(
              future: DataService.fetchTrendingCardsFromNetwork(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final cards = snapshot.data as List<CardModel>;
                  if (cards.isNotEmpty) {
                    return Expanded(
                        child: ListView.separated(
                      itemCount: cards.length,
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 0.4,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 80,
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            child: CardListItemWidget(
                              cardModel: cards[index],
                            ),
                            onTap: () =>
                                onCardTapped(cards[index].id),
                          ),
                        );
                      },
                    ));
                  }
                }
                return AutoSizeText(
                  "Nothing trending",
                  maxLines: 1,
                  style: GoogleFonts.roboto(
                      fontSize: 12, fontWeight: FontWeight.w200, height: 1.4),
                );
              }),
        ],
      ),
    );
  }
}
