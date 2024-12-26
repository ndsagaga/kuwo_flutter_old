import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuwo/models/card_model.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CardBodyWidget extends StatelessWidget {
  final CardModel card;

  const CardBodyWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    int maxLines = MediaQuery.of(context).size.height > 900 ? 12 : 11;
    
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AutoSizeText(
            card.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
                fontSize: 20, fontWeight: FontWeight.w600, height: 1.4),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            card.body,
            maxLines: maxLines,
            minFontSize: 16,
            stepGranularity: 0.25,
            style: GoogleFonts.roboto(
                fontSize: 19, height: 1.4, fontWeight: FontWeight.w300),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                card.formattedTimestamp,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
