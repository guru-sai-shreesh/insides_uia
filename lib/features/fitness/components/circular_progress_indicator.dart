import 'package:flutter/material.dart';
import 'package:insides/model/colors.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgressComponent extends StatelessWidget {
  final double progress;
  final String secondaryText;
  final String primaryText;
  final Color color;
  final double height;
  final double width;

  const RadialProgressComponent({
    Key? key,
    required this.progress,
    required this.color,
    required this.height,
    required this.width,
    required this.secondaryText,
    required this.primaryText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final minSide = width < height ? width : height;

        return Container(
          width: minSide,
          height: minSide,
          child: CustomPaint(
            painter: _RadialPainter(
                progress: progress, color: color, minSide: minSide),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    primaryText,
                    style: TextStyle(
                      fontSize: minSide * 0.1,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    secondaryText,
                    style: TextStyle(
                      fontSize: minSide * 0.05,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RadialPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double minSide;
  _RadialPainter({
    required this.progress,
    required this.color,
    required this.minSide,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 10.0;
    final double radius = (minSide - strokeWidth) / 2.0;
    final Offset center = size.center(Offset.zero);

    Paint paintf = Paint()
      ..strokeWidth = strokeWidth
      ..color = color.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double relativeProgress = 360 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.radians(-90),
      math.radians(360),
      false,
      paintf,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.radians(-90),
      math.radians(-relativeProgress),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
