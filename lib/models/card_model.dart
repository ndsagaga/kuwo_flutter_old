import 'package:intl/intl.dart';

class CardModel {
  final String id;
  final String imageUrl;
  final String title;
  final String body;
  final String url;
  final double timestamp;
  final String sourceIcon;
  final String sourceName;
  bool read = false;
  bool liked = false;

  CardModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.body,
    required this.url,
    required this.timestamp,
    required this.sourceIcon,
    required this.sourceName,
    this.read = false,
    this.liked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'body': body,
      'url': url,
      'timestamp': timestamp,
      'sourceIcon': sourceIcon,
      'sourceName': sourceName,
      'read': read,
      'liked': liked
    };
  }

  String get formattedTimestamp {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
    return DateFormat('d MMMM').format(dateTime);
  }
}
