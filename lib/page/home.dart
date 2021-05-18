import 'dart:math' as math;

import 'package:basic_utils/basic_utils.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 0.8);

  void _goToPage(index) {
    controller.animateToPage(
      index,
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  Color _setCardColor(int index) {
    switch (index + 1) {
      case 1:
        return cardColor1;
      case 2:
        return cardColor2;
      case 3:
        return cardColor3;
      case 4:
        return cardColor4;
      case 5:
        return cardColor5;
      case 6:
        return cardColor6;
      default:
        return canvasColor;
    }
  }

  SizedBox _paddingBox() {
    return SizedBox(height: defaultPadding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(StringUtils.capitalize(home)),
      ),
      body: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _paddingBox(),
              SizedBox(
                height: 300,
                child: PageView(
                  controller: controller,
                  children: List.generate(
                      6,
                      (_cardIndex) => Card(
                            color: _setCardColor(_cardIndex),
                            shadowColor: bgColorDarker,
                            elevation: defaultElevation / 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Container(height: 280),
                          )),
                ),
              ),
              _paddingBox(),
              Padding(
                padding: EdgeInsets.only(
                    top: defaultPadding, bottom: defaultPadding / 2),
                child: Text('Worm'),
              ),
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 6,
                  onDotClicked: _goToPage,
                  effect: WormEffect(
                    dotColor: dotColor,
                    activeDotColor: activeDotColor,
                  ),
                ),
              ),
              _paddingBox(),
              Padding(
                padding: EdgeInsets.only(
                    top: defaultPadding, bottom: defaultPadding / 2),
                child: Text('Expanding Dots'),
              ),
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 6,
                  onDotClicked: _goToPage,
                  effect: ExpandingDotsEffect(
                    dotColor: dotColor,
                    activeDotColor: activeDotColor,
                    expansionFactor: 4,
                  ),
                ),
              ),
              _paddingBox(),
              Padding(
                padding: const EdgeInsets.only(
                    top: defaultPadding, bottom: defaultPadding / 2),
                child: Text('Jumping Dot'),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: 6,
                onDotClicked: _goToPage,
                effect: JumpingDotEffect(
                  dotColor: dotColor,
                  activeDotColor: activeDotColor,
                ),
              ),
              _paddingBox(),
              Padding(
                padding: const EdgeInsets.only(
                    top: defaultPadding, bottom: defaultPadding / 2),
                child: Text('Scale'),
              ),
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 6,
                  onDotClicked: _goToPage,
                  effect: ScaleEffect(
                    dotColor: dotColor,
                    activeDotColor: activeDotColor,
                  ),
                ),
              ),
              _paddingBox(),
              Padding(
                padding: const EdgeInsets.only(
                    top: defaultPadding, bottom: defaultPadding / 2),
                child: Text('Slide'),
              ),
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 6,
                  onDotClicked: _goToPage,
                  effect: SlideEffect(
                      spacing: 8.0,
                      radius: 4.0,
                      dotWidth: 24.0,
                      dotHeight: 16.0,
                      dotColor: dotColor,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1,
                      activeDotColor: activeDotColor),
                ),
              ),
              _paddingBox(),
              _paddingBox(),
              FloatingActionButton(
                backgroundColor: secondaryColor,
                elevation: defaultElevation / 4,
                child: Transform.rotate(
                  angle: math.pi / 4,
                  child: Icon(Icons.navigation_outlined),
                ),
                onPressed: () => context.beamToNamed(polygons),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
