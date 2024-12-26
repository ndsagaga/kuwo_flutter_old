import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:kuwo/changenotifiers/cards.dart';
import 'package:kuwo/changenotifiers/current_card_index.dart';
import 'package:provider/provider.dart';
import '../models/card_model.dart';
import '../widgets/card_widget.dart';
import '../widgets/stacked_page_view.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Consumer2(builder:
            (context, Cards cards, CurrentCardIndex currentCardIndex, child) {
          if (cards.cards.isEmpty) {
            return child  ?? noCardsWidget();
          }
          final pageController =
              PageController(initialPage: currentCardIndex.value);
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: cards.cards.length,
            controller: pageController,
            onPageChanged: currentCardIndex.updateCurrentCardIndex,
            itemBuilder: (context, index) {
              return StackPageView(
                controller: pageController,
                index: index,
                child: CardWidget(cardModel: cards.cards[index]),
              );
            },
          );
        },
        child: noCardsWidget(),),
      ),
    );
  }

  Widget noCardsWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.info_outline,
            size: 50.0,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            'Sorry, we have no news articles for you',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
