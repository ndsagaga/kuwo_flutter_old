import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/card_model.dart';

const _sharedPrefKey = "cards";

class DataService {
  static List<CardModel> fetchAllCardsFromPref(SharedPreferences prefs) {
    final savedJson = prefs.getString(_sharedPrefKey);
    if (savedJson == null) return [];

    final rawData = json.decode(savedJson) as List;

    FirebaseAnalytics.instance.logEvent(
        name: 'pref_fetch', parameters: {'cards_count': rawData.length});

    return rawData
        .map((item) => CardModel(
              id: item["id"],
              imageUrl: item['imageUrl'],
              title: item['title'],
              body: item['body'],
              url: item['url'],
              timestamp: item['timestamp'],
              sourceIcon: item['sourceIcon'],
              sourceName: item['sourceName'],
              read: item['read'],
              liked: item['liked']
            ))
        .toList();
  }

  static Future<List<CardModel>> fetchAllCardsFromNetwork() async {
    final response = await http.get(
      Uri.parse('https://storage.googleapis.com/kuwo/articles.json'),
    );

    List<CardModel> cards = [];

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      final networkData = json.decode(utf8Response) as List;
      cards = networkData
          .map((item) => CardModel(
                id: item['id'],
                imageUrl: item['image_url'],
                title: item['display_title'],
                body: item['display_content'],
                url: item['url'],
                timestamp: item['timestamp'],
                sourceIcon: item['source_icon'] ?? "",
                sourceName: item['source_name'] ?? "Original article",
              ))
          .toList();
    }

    FirebaseAnalytics.instance.logEvent(name: 'all_cards_fetch', parameters: {
      'status_code': response.statusCode,
      'cards_count': cards.length
    });

    return cards;
  }

  static Future<List<CardModel>> fetchTrendingCardsFromNetwork() async {
    final response = await http.get(
      Uri.parse('https://storage.googleapis.com/kuwo/trending_articles.json'),
    );

    List<CardModel> cards = [];

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      final networkData = json.decode(utf8Response) as List;
      cards = networkData
          .map((item) => CardModel(
                id: item['id'],
                imageUrl: item['image_url'],
                title: item['display_title'],
                body: item['display_content'],
                url: item['url'],
                timestamp: item['timestamp'],
                sourceIcon: item['source_icon'] ?? "",
                sourceName: item['source_name'] ?? "Original article",
              ))
          .toList();
    }

    FirebaseAnalytics.instance.logEvent(name: 'trending_cards_fetch', parameters: {
      'status_code': response.statusCode,
      'cards_count': cards.length
    });

    return cards;
  }

  static List<CardModel> mergeLists(
      List<CardModel> networkCards, List<CardModel> savedCards) {
    final Map<String, int> articleIdToIndexMap = {};
    networkCards.asMap().forEach((i, card) => articleIdToIndexMap[card.id] = i);

    int readCount = 0;
    int missCount = 0;
    for (var card in savedCards) {
      if (articleIdToIndexMap.containsKey(card.id)) {
        if (card.read) {
          readCount += 1;
        }
        networkCards[articleIdToIndexMap[card.id]!].read = card.read;
        networkCards[articleIdToIndexMap[card.id]!].liked = card.liked;
      } else {
        missCount += 1;
      }
    }

    FirebaseAnalytics.instance.logEvent(
        name: 'merge_cards',
        parameters: {'read_count': readCount, 'miss_count': missCount});

    networkCards.sort((a, b) {
      if (a.read == b.read) {
        return 0;
      } else if (a.read) {
        return 1;
      }
      return -1;
    });

    return networkCards;
  }

  static void saveToPref(SharedPreferences prefs, List<CardModel> cards) {
    prefs.setString(
        _sharedPrefKey, jsonEncode(cards.map((c) => c.toJson()).toList()));
  }
}
