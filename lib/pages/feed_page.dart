import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:kuwo/changenotifiers/cards.dart';
import 'package:kuwo/changenotifiers/current_card_index.dart';
import 'package:kuwo/widgets/liked_cards_widget.dart';
import 'package:kuwo/widgets/search_field_widget.dart';
import 'package:kuwo/widgets/trending_cards_widget.dart';
import 'package:provider/provider.dart';
import '../models/card_model.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer(builder: (context, Cards cards, child) {
          return Column(
            children: [
              SearchFieldWidget(
                cards: cards.cards,
                onCardTapped: (String id) =>
                    Provider.of<CurrentCardIndex>(context, listen: false)
                        .setCurrentCardIndex(cards.indexOfCardWithID(id)),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                        child: TrendingCardsWidget(
                            onCardTapped: (String id) =>
                                Provider.of<CurrentCardIndex>(context,
                                        listen: false)
                                    .setCurrentCardIndex(
                                        cards.indexOfCardWithID(id)))),
                    Expanded(
                        child: LikedCardsWidget(
                            cards: cards.cards,
                            onCardTapped: (String id) =>
                                Provider.of<CurrentCardIndex>(context,
                                        listen: false)
                                    .setCurrentCardIndex(
                                        cards.indexOfCardWithID(id)))),
                  ],
                ),
              )
            ],
          );
        }));
  }
}
