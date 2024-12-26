import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuwo/widgets/card_list_item_widget.dart';
import '../models/card_model.dart';
import '../services/data_service.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LikedCardsWidget extends StatelessWidget {
  final List<CardModel> cards;
  final Function(String) onCardTapped;
  const LikedCardsWidget({super.key, required this.cards, required this.onCardTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(children: [
            const Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 44, 44, 44),
              size: 25,
            ),
            const SizedBox(width: 5),
            AutoSizeText(
              "Liked",
              maxLines: 1,
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                  color: const Color.fromARGB(255, 44, 44, 44)),
            ),
          ]),
          const Divider(),
          Builder(builder: (context) {
            final likedCards = cards.where((e) => e.liked).toList();
            if (likedCards.isEmpty) {
              return Center(
                  child: AutoSizeText(
                "You have not liked anything!",
                maxLines: 1,
                style: GoogleFonts.roboto(
                    fontSize: 12, fontWeight: FontWeight.w200, height: 1.4),
              ));
            }
            return Expanded(
                child: ListView.builder(
              itemCount: likedCards.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 90,
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    child: CardListItemWidget(cardModel: likedCards[index]),
                    onTap: () => onCardTapped(likedCards[index].id),
                  ),
                );
              },
            ));
          })
        ],
      ),
    );
  }
}
