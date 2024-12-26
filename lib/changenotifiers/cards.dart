import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kuwo/models/card_model.dart';
import 'package:kuwo/services/data_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cards extends ChangeNotifier {
  final List<CardModel> cards;

  Cards({required this.cards});

  void setLiked(int index, bool liked) async {
    if (index < 0 || index >= cards.length) {
      return;
    }
    cards[index].liked = liked;
    save();
    notifyListeners();
  }

  void save() async {
    DataService.saveToPref(await SharedPreferences.getInstance(), cards);
  }

  static Future<Cards> fromNetwork() async {
    return Cards(cards: await fetchAllCards());
  }

  static Future<List<CardModel>> fetchAllCards() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCards = DataService.fetchAllCardsFromPref(prefs);
    final networkCards = await DataService.fetchAllCardsFromNetwork();
    final cards = DataService.mergeLists(networkCards, savedCards);
    DataService.saveToPref(prefs, cards);

    return cards;
  }

  int indexOfCardWithID(String id) {
    return cards.indexWhere((card) => card.id == id);
  }
}
