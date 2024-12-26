import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuwo/changenotifiers/cards.dart';
import 'package:kuwo/models/card_model.dart';
import 'package:provider/provider.dart';

class CardFooterWidget extends StatefulWidget {
  final CardModel card;

  const CardFooterWidget({super.key, required this.card});

  @override
  CardFooterWidgetState createState() => CardFooterWidgetState();
}

class CardFooterWidgetState extends State<CardFooterWidget> {
  @override
  Widget build(BuildContext context) {
    launchURL() async {
      FirebaseAnalytics.instance
          .logEvent(name: 'read_more', parameters: {'card_id': widget.card.id});
      await FlutterWebBrowser.openWebPage(url: widget.card.url);
    }

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        color: Color.fromARGB(255, 73, 10, 14),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          children: [
            Flexible(
              flex: 9,
              child: GestureDetector(
                onTap: launchURL,
                child: Row(children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        widget.card.sourceIcon,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          FirebaseAnalytics.instance.logEvent(
                              name: 'source_image_load_failure',
                              parameters: {'card_id': widget.card.id});
                          return Container(
                            color: const Color(0xFFF3D2BB),
                          );
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.card.sourceName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1.4),
                          ),
                          Text(
                            "Tap to read more",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.4),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                padding: const EdgeInsets.all(4),
                icon: widget.card.liked
                    ? const Icon(Icons.favorite, color: Colors.white)
                    : const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {
                  final cards = Provider.of<Cards>(context, listen: false);
                  final index = cards.indexOfCardWithID(widget.card.id);
                  cards.setLiked(index, !widget.card.liked);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
