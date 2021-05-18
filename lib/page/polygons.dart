import 'dart:math' as math;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PolygonsPage extends StatefulWidget {
  @override
  _PolygonsPageState createState() => _PolygonsPageState();
}

class _PolygonsPageState extends State<PolygonsPage>
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
      duration: Duration(seconds: 4),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    var _radiusTween = Tween<double>(begin: 0.0, end: 200);
    var _rotationTween = Tween<double>(begin: -math.pi, end: math.pi);

    animation = _rotationTween.animate(controller)
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

    animation2 = _radiusTween.animate(controller2)
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text(StringUtils.capitalize(polygons)),
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
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text('Sides'),
            ),
            Slider(
              activeColor: primaryColor,
              inactiveColor: bgColorDarker,
              value: _sides,
              min: 3.0,
              max: 10.0,
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
        textStyle: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
        boxHeight: 100.0,
        waveDuration: Duration(seconds: 8),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final double sides;
  final double radius;
  final double radians;
  ShapePainter(this.sides, this.radius, this.radians);

  @override
  void paint(Canvas canvas, Size size) {
    var _paint = Paint()
      ..color = secondaryColor
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var _path = Path();

    var _angle = (math.pi * 2) / sides;

    var _center = Offset(size.width / 2, size.height / 2);
    var _startPoint =
        Offset(radius * math.cos(radians), radius * math.sin(radians));

    _path.moveTo(_startPoint.dx + _center.dx, _startPoint.dy + _center.dy);

    for (var i = 1; i <= sides; i++) {
      var _x = radius * math.cos(radians + _angle * i) + _center.dx;
      var _y = radius * math.sin(radians + _angle * i) + _center.dy;
      _path.lineTo(_x, _y);
    }
    _path.close();
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
