import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'constants/current_page.enum.dart';
import 'page/error.dart';
import 'page/home.dart';
import 'page/login.page.dart';
import 'page/polygons.dart';
import 'pods/auth.pod.dart';
import 'pods/current_page.pod.dart';
import 'states/auth.state.dart';

// * wrap GoRouter with Provider for ref to watch authStateNotifierPod
final appRouter = Provider<GoRouter>(
  (ref) => GoRouter(
    debugLogDiagnostics: kDebugMode,
    restorationScopeId: 'router',
    urlPathStrategy: UrlPathStrategy.path,
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
      GoRoute(
        path: CURRENT_PAGE.login.toPath(),
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: LoginPage(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: ErrorPage(state.error),
    ),
    redirect: (state) {
      // * hack: https://github.com/rrousselGit/river_pod/issues/815
      // * use ref.read() instead of ref.watch()
      final _authStateProvider = ref.read(authStateNotifierPod);
      final _routeToPath = state.location;

      if (kDebugMode) {
        print('|.. _routeToPath: $_routeToPath');
        print('\\.... _authStatus: ${_authStateProvider.status}');
      }
      // * not just authStatus but also check the path to go as well
      if (_authStateProvider.status == AuthStatus.unauthenticated &&
          _routeToPath != CURRENT_PAGE.login.toPath()) {
        return CURRENT_PAGE.login.toPath();
      }
      if (_authStateProvider.status == AuthStatus.authenticated &&
          _routeToPath == CURRENT_PAGE.login.toPath()) {
        return CURRENT_PAGE.home.toPath();
      }

      // * go_router got to hit this null at the end to finish routing
      return null;
    },
  ),
);

// * provide this Listenable to be listened for refreshing of routing
final refreshListenableProvider = Provider(
  (ref) => Listenable.merge(
    [
      ValueNotifier(ref.watch(authStateNotifierPod.select((state) => state))),
    ],
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
