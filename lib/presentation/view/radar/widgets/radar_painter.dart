import 'dart:math';
import 'package:antiradar/presentation/view_model/isar/models/country_model.dart';
import 'package:antiradar/utils/app_colors.dart';
import 'package:antiradar/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RadarPainter extends CustomPainter {
  //final ui.Image image;
  final List<Offset> points;
  final List<CountryModel> models;
  final PictureInfo picture;
  final RadialGradient gradient;
  final Color linesColor;

  RadarPainter({
    super.repaint,
    //required this.image,
    required this.points,
    required this.models,
    required this.picture,
    required this.gradient,
    required this.linesColor
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 1.3);
    final radius = min(size.width, size.height) / 0.8;

    final paint = Paint()
      ..color = linesColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw circles
    for (var i = 1; i <= 3; i++) {
      canvas.drawCircle(center, radius * i / 3, paint);
    }

    final sectorPaint = Paint()
      ..color = linesColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (var i = 5.5; i < 7.5; i++) {
      final angle = i * pi / 4;
      final dx = cos(angle) * radius;
      final dy = sin(angle) * radius;
      canvas.drawLine(center, center + Offset(dx, dy), sectorPaint);
    }

    final sectorPath = Path()
      ..moveTo(center.dx, center.dy - 25)
      ..lineTo(
        center.dx + radius * cos(-pi / 2 - pi / 20),
        (center.dy - 25) + radius * sin(-pi / 2 - pi / 20),
      )
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2 - pi / 20,
        pi / 10,
        false,
      )
      ..lineTo(center.dx, center.dy - 25);

    /*final gradient = RadialGradient(
      colors: [
        Colors.white.withOpacity(0.1),
        Colors.transparent,
      ],
      stops: const [0.8, 1.0],
    );*/

    final sectorPaintFill = Paint()
      ..shader =
          gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    canvas.drawPath(sectorPath, sectorPaintFill);

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    void drawText(String text, Offset position) {
      textPainter.text = TextSpan(
        text: text,
        style: AppFonts.sfProMedium.copyWith(color: AppColors.metresColor, fontSize: 14),
      );
      textPainter.layout();
      textPainter.paint(canvas,
          position - Offset(textPainter.width / 2, textPainter.height / 0.3));
    }

    drawText('200m', Offset(center.dx, center.dy - radius / 3));
    drawText('500m', Offset(center.dx, center.dy - radius * 2 / 3));

    /*canvas.drawImage(image,
        Offset((size.width / 2) - 20, (size.height / 1.3) - 20), Paint());*/
    canvas.save();
    canvas.translate((size.width / 2) - 20, (size.height / 1.3) - 20);
    canvas.drawPicture(picture.picture);
    canvas.restore();

    final pointPaint = Paint()
      ..color = AppColors.redColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final outerRadius = size.width / 2;
      final innerRadius = size.width / 4;
      final outerCirclePaint = Paint()
        ..color = AppColors.redColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(points[i], 8.0, outerCirclePaint);
      final innerCirclePaint = Paint()
        ..color = AppColors.redColor
        ..style = PaintingStyle.fill;

      canvas.drawCircle(points[i], 4.0, innerCirclePaint);

      drawText('${models[i].lat}, ${models[i].long}', points[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
