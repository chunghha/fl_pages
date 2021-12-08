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
    final _currentPageProvider = ref.watch(currentPagePod);

    return BottomNavigationBar(
      backgroundColor: bgColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: CURRENT_PAGE.home.toIcon(),
          label: CURRENT_PAGE.home.toLabel(),
        ),
        BottomNavigationBarItem(
          icon: CURRENT_PAGE.polygon.toIcon(),
          label: CURRENT_PAGE.polygon.toLabel(),
        ),
        BottomNavigationBarItem(
          icon: CURRENT_PAGE.form.toIcon(),
          label: CURRENT_PAGE.form.toLabel(),
        ),
      ],
      currentIndex: _currentPageProvider.last.currentPage.toIndex(),
      onTap: (_index) {
        if (kDebugMode) {
          print('|.. _index onTap: $_index');
        }
        ref.read(currentPagePod.notifier).update(
              CurrentPageState(
                CURRENT_PAGE.values[_index],
                CURRENT_PAGE.values[_index].toPath(),
              ),
            );
        goForward(
          context: context,
          ref: ref,
          pageToGo: CURRENT_PAGE.values[_index],
        );
      },
    );
  }
}
