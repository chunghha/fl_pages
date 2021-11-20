import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/constants.dart';
import '../constants/current_page.enum.dart';
import '../pods/current_page.pod.dart';

class MyNavigator extends HookConsumerWidget {
  const MyNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentPageProvider = ref.watch(currentPagePod);

    void _goToPage(CURRENT_PAGE index) {
      switch (index) {
        case CURRENT_PAGE.home:
          return context.go(CURRENT_PAGE.home.toPath());
        case CURRENT_PAGE.polygon:
          return context.go(CURRENT_PAGE.polygon.toPath());
        default:
          break;
      }
    }

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
      ],
      currentIndex: _currentPageProvider,
      onTap: (_index) {
        ref.read(currentPagePod.notifier).update(_index);
        _goToPage(CURRENT_PAGE.values[_index]);
      },
    );
  }
}
