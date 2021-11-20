import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'constants/current_page.enum.dart';
import 'page/error.dart';
import 'page/home.dart';
import 'page/polygons.dart';
import 'pods/current_page.pod.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: CURRENT_PAGE.home.toPath(),
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: HomePage(),
      ),
    ),
    GoRoute(
      path: CURRENT_PAGE.polygon.toPath(),
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: PolygonsPage(),
      ),
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage<void>(
    key: state.pageKey,
    child: ErrorPage(state.error),
  ),
);

void goToPage({
  required BuildContext context,
  required WidgetRef ref,
  required CURRENT_PAGE pageToGo,
}) {
  ref.read(currentPagePod.notifier).update(pageToGo.toIndex());
  context.go(pageToGo.toPath());
}
