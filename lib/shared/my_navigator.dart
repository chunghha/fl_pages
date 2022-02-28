import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/constants.dart';
import '../constants/current_page.enum.dart';
import '../pods/current_page.pod.dart';
import '../states/current_page.state.dart';
import 'router.helper.dart';

class MyNavigator extends HookConsumerWidget {
  const MyNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageProvider = ref.watch(currentPagePod);

    return BottomNavigationBar(
      backgroundColor: bgColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: CURRENT_PAGE.home.toIcon(),
          label: StringUtils.capitalize(CURRENT_PAGE.home.name),
        ),
        BottomNavigationBarItem(
          icon: CURRENT_PAGE.polygon.toIcon(),
          label: StringUtils.capitalize(CURRENT_PAGE.polygon.name),
        ),
        BottomNavigationBarItem(
          icon: CURRENT_PAGE.form.toIcon(),
          label: StringUtils.capitalize(CURRENT_PAGE.form.name),
        ),
      ],
      currentIndex: currentPageProvider.last.currentPage.toIndex(),
      onTap: (index) {
        if (kDebugMode) {
          print('|.. _index onTap: $index');
        }
        ref.read(currentPagePod.notifier).update(
              CurrentPageState(
                CURRENT_PAGE.values[index],
                CURRENT_PAGE.values[index].toPath(),
              ),
            );
        goForward(
          context: context,
          ref: ref,
          pageToGo: CURRENT_PAGE.values[index],
        );
      },
    );
  }
}
