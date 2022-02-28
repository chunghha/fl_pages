import 'dart:math' as math;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/current_page.enum.dart';
import '../shared/my_scaffold.dart';

class PolygonsPage extends StatefulWidget {
  const PolygonsPage({Key? key}) : super(key: key);

  @override
  PolygonsPageState createState() => PolygonsPageState();
}

class PolygonsPageState extends State<PolygonsPage>
    with TickerProviderStateMixin {
  var _sides = 3.0;

  late Animation<double> animation;
  late AnimationController controller;

  late Animation<double> animation2;
  late AnimationController controller2;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    final radiusTween = Tween<double>(begin: 0, end: 200);
    final rotationTween = Tween<double>(begin: -math.pi, end: math.pi);

    animation = rotationTween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    animation2 = radiusTween.animate(controller2)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });

    controller.forward();
    controller2.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text(CURRENT_PAGE.polygon.toTitle()),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getAnimatedText(),
            Expanded(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, snapshot) {
                  return CustomPaint(
                    painter:
                        ShapePainter(_sides, animation2.value, animation.value),
                    child: Container(),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24),
              child: Text('Sides'),
            ),
            Slider(
              activeColor: primaryColor,
              inactiveColor: bgColorDarker,
              value: _sides,
              min: 3,
              max: 10,
              label: _sides.toInt().toString(),
              divisions: 7,
              onChanged: (value) {
                setState(() {
                  _sides = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAnimatedText() {
    return SizedBox(
      width: 600,
      child: TextLiquidFill(
        text: 'Try to change the sides.',
        waveColor: dotColor,
        boxBackgroundColor: bgColor,
        textStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        boxHeight: 100,
        waveDuration: const Duration(seconds: 8),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  ShapePainter(this.sides, this.radius, this.radians);

  final double sides;
  final double radius;
  final double radians;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = secondaryColor
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    final angle = (math.pi * 2) / sides;

    final center = Offset(size.width / 2, size.height / 2);
    final startPoint =
        Offset(radius * math.cos(radians), radius * math.sin(radians));

    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

    for (var i = 1; i <= sides; i++) {
      final x = radius * math.cos(radians + angle * i) + center.dx;
      final y = radius * math.sin(radians + angle * i) + center.dy;
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
