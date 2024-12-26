import 'package:flutter/material.dart';
import 'package:kuwo/widgets/card_body_widget.dart';
import 'package:kuwo/widgets/card_footer_widget.dart';
import 'package:kuwo/widgets/card_image_widget.dart';
import '../models/card_model.dart';

class CardWidget extends StatelessWidget {
  final CardModel cardModel;

  const CardWidget({super.key, required this.cardModel});

  @override
  Widget build(BuildContext context) {
    cardModel.read = true;

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black),
        child: Column(
          children: [
            Expanded(
              flex: 30,
              child: CardImageWidget(card: cardModel,),
            ),
            Expanded(
              flex: 60,
              child: CardBodyWidget(card: cardModel,),
            ),
            Expanded(
              flex: 10,
              child: CardFooterWidget(card: cardModel,),
            ),
          ],
        ));
  }
}
