import 'package:flutter/material.dart';
import 'package:kuwo/changenotifiers/current_card_index.dart';
import 'package:kuwo/pages/feed_page.dart';
import 'package:kuwo/pages/cards_page.dart';
import 'package:provider/provider.dart';
import '../models/card_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 1);

    Provider.of<CurrentCardIndex>(context, listen: false).addListener(() {
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });

    final pages = [const FeedPage(), const CardsPage()];

    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: pages.length,
      controller: pageController,
      itemBuilder: (context, index) {
        return pages[index];
      },
    );
  }
}
