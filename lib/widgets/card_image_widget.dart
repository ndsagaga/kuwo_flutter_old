import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuwo/models/card_model.dart';

class CardImageWidget extends StatelessWidget {
  final CardModel card;

  const CardImageWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background image
        Positioned.fill(
          child: Image.network(
            card.imageUrl,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.2),
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        ),
        // Foreground image
        Center(
          child: Image.network(
            card.imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              FirebaseAnalytics.instance.logEvent(
                name: 'image_load_failure',
                parameters: {'card_id': card.id},
              );
              return Container(
                width: double.infinity,
                color: const Color(0xFFF3D2BB),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Color(0xFFB42D1E),
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Failed to load image',
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: const Color(0xFFB42D1E)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
