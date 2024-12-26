library stacked_page_view;

import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class StackPageView extends StatefulWidget {
  const StackPageView({
    super.key,
    required this.index,
    required this.controller,
    required this.child,
    this.animationAxis = Axis.vertical,
    this.backgroundColor = Colors.transparent,
  });
  final int index;
  final PageController controller;
  final Widget child;
  final Axis animationAxis;
  final Color backgroundColor;
  @override
  StackPageViewState createState() => StackPageViewState();
}

class StackPageViewState extends State<StackPageView> {
  int currentPosition = 0;
  double pagePosition = 0.0;

  @override
  void initState() {
    super.initState();
    currentPosition = widget.index;
    pagePosition = widget.index.toDouble();
    if (widget.controller.position.haveDimensions) {
      widget.controller.addListener(() {
        _listener();
      });
    }
  }

  _listener() {
    if (mounted) {
      setState(() {
        pagePosition =
            num.parse(widget.controller.page!.toStringAsFixed(4)) as double;
        currentPosition = widget.controller.page!.floor();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 15.0;
    final size = MediaQuery.of(context).size;
    final isCurrentCard = currentPosition == widget.index;
    final double startFactor = Platform.isIOS ? 0.09 : 0.095;
    return Scaffold(
      backgroundColor: isCurrentCard ? Colors.transparent : Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double delta = pagePosition - widget.index;
          double sides = padding * max(-delta, 0.0);
          double start = widget.animationAxis == Axis.horizontal
              ? (size.width * startFactor) * delta.abs() * 10
              : (size.height * startFactor) * delta.abs() * 10;

          double opac = (sides / 0.5) * 0.1;
          double anotheropac = 0.0;
          if (num.parse(opac.toStringAsFixed(2)) <= 1.0) {
            anotheropac = num.parse(opac.toStringAsFixed(3)) * 0.5;
          } else if (num.parse(opac.toStringAsFixed(2)) >= 1.0) {
            anotheropac = 0.5;
          } else {
            anotheropac = num.parse(opac.toStringAsFixed(3)) * 0.07;
          }
          return ClipRRect(
            borderRadius: isCurrentCard
                ? BorderRadius.circular(10)
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
            child: ColorFiltered(
              colorFilter: isCurrentCard
                  ? ColorFilter.mode(widget.backgroundColor.withOpacity(0.01),
                      BlendMode.darken)
                  : ColorFilter.mode(
                      widget.backgroundColor.withOpacity(anotheropac),
                      BlendMode.darken),
              child: Align(
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: isCurrentCard
                      ? const Offset(0, 0)
                      : (widget.animationAxis == Axis.horizontal
                          ? Offset(start, 0)
                          : Offset(0, -start)),
                  child: Transform.scale(
                    scale: isCurrentCard
                        ? 1
                        : 0.9 +
                            0.1 *
                                (1 - pow(delta.abs(), 2)), // Slows down scaling
                    child: widget.child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
