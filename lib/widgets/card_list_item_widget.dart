import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuwo/widgets/card_image_widget.dart';
import '../models/card_model.dart';

class CardListItemWidget extends StatelessWidget {
  final CardModel cardModel;

  const CardListItemWidget({super.key, required this.cardModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(50),
              child: Image.network(
                cardModel.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    color: const Color(0xFFF3D2BB),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Color(0xFFB42D1E),
                          size: 20,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Failed to load image',
                          style: GoogleFonts.roboto(
                              fontSize: 7, color: const Color(0xFFB42D1E)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Expanded(
          flex: 75,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  cardModel.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.w600, height: 1.4),
                ),
                AutoSizeText(
                  cardModel.formattedTimestamp,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                      fontSize: 11, fontWeight: FontWeight.w400, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
