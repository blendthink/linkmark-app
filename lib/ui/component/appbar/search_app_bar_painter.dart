import 'package:flutter/material.dart';

class SearchAppBarPainter extends CustomPainter {
  static const double _defaultElevation = 4.0;
  static final Color _defaultShadowColor =
      const Color(0xFF000000).withAlpha(40);

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  final Offset center;
  final double radius, containerHeight;
  final BuildContext context;

  final Color color;
  late double statusBarHeight, screenWidth;

  SearchAppBarPainter({
    required this.context,
    required this.containerHeight,
    required this.center,
    required this.radius,
    required this.color,
  }) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        Path()
          ..addRect(Rect.fromPoints(const Offset(0, 0),
              Offset(size.width, size.height + _defaultElevation)))
          ..addRect(Rect.fromPoints(
              const Offset(0, 0), Offset(size.width, size.height)))
          ..fillType = PathFillType.evenOdd,
        Paint()
          ..color = _defaultShadowColor
          ..maskFilter =
              MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(3)));

    canvas.clipRect(
        Rect.fromLTWH(0, 0, screenWidth, containerHeight + statusBarHeight));

    final circlePainter = Paint();
    circlePainter.color = color;
    canvas.drawCircle(center, radius, circlePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
