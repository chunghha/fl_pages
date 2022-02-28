import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/constants.dart';
import '../constants/current_page.enum.dart';
import '../shared/my_scaffold.dart';
import '../shared/router.helper.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final controller = PageController(viewportFraction: 0.8);

  void _goToPage(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 700),
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

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(CURRENT_PAGE.home.toTitle()),
      ),
      body: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Gap(defaultPadding),
                SizedBox(
                  height: 300,
                  child: PageView(
                    controller: controller,
                    children: List.generate(
                      6,
                      (cardIndex) => Card(
                        color: _setCardColor(cardIndex),
                        shadowColor: bgColorDarker,
                        elevation: defaultElevation / 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Container(height: 280),
                      ),
                    ),
                  ),
                ),
                const Gap(defaultPadding),
                const Padding(
                  padding: EdgeInsets.only(
                    top: defaultPadding,
                    bottom: defaultPadding / 2,
                  ),
                  child: Text('Worm'),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: 6,
                  onDotClicked: _goToPage,
                  effect: const WormEffect(
                    dotColor: dotColor,
                    activeDotColor: activeDotColor,
                  ),
                ),
                const Gap(defaultPadding / 2),
                const Padding(
                  padding: EdgeInsets.only(
                    top: defaultPadding,
                    bottom: defaultPadding / 2,
                  ),
                  child: Text('Expanding Dots'),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: 6,
                  onDotClicked: _goToPage,
                  effect: const ExpandingDotsEffect(
                    dotColor: dotColor,
                    activeDotColor: activeDotColor,
                    expansionFactor: 4,
                  ),
                ),
                const Gap(defaultPadding / 2),
                const Padding(
                  padding: EdgeInsets.only(
                    top: defaultPadding,
                    bottom: defaultPadding / 2,
                  ),
                  child: Text('Scale'),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: 6,
                  onDotClicked: _goToPage,
                  effect: const ScaleEffect(
                    dotColor: dotColor,
                    activeDotColor: activeDotColor,
                  ),
                ),
                const Gap(defaultPadding / 2),
                const Padding(
                  padding: EdgeInsets.only(
                    top: defaultPadding,
                    bottom: defaultPadding / 2,
                  ),
                  child: Text('Slide'),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: 6,
                  onDotClicked: _goToPage,
                  effect: const SlideEffect(
                    radius: 4,
                    dotWidth: 24,
                    dotColor: dotColor,
                    paintStyle: PaintingStyle.stroke,
                    activeDotColor: activeDotColor,
                  ),
                ),
                const Gap(defaultPadding * 1.5),
                FloatingActionButton(
                  backgroundColor: secondaryColor,
                  elevation: defaultElevation / 4,
                  child: Transform.rotate(
                    angle: math.pi / 4,
                    child: const Icon(Icons.navigation_outlined),
                  ),
                  onPressed: () => goForward(
                    context: context,
                    ref: ref,
                    pageToGo: CURRENT_PAGE.polygon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
