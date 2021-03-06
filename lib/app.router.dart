import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'constants/current_page.enum.dart';
import 'page/error.dart';
import 'page/form.page.dart';
import 'page/home.dart';
import 'page/login.page.dart';
import 'page/polygons.dart';
import 'pods/auth.pod.dart';
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
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: CURRENT_PAGE.polygon.toPath(),
        builder: (context, state) => const PolygonsPage(),
      ),
      GoRoute(
        path: CURRENT_PAGE.form.toPath(),
        builder: (context, state) => const FormPage(),
      ),
      GoRoute(
        path: CURRENT_PAGE.login.toPath(),
        builder: (context, state) => const LoginPage(),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(state.error),
    redirect: (state) {
      // * hack: https://github.com/rrousselGit/river_pod/issues/815
      // * use ref.read() instead of ref.watch()
      final authStateProvider = ref.read(authStateNotifierPod);
      final routeToPath = state.location;

      if (kDebugMode) {
        print('|.. _routeToPath: $routeToPath');
        print('\\.... _authStatus: ${authStateProvider.status}');
      }
      // * not just authStatus but also check the path to go as well
      if (authStateProvider.status == AuthStatus.unauthenticated &&
          routeToPath != CURRENT_PAGE.login.toPath()) {
        return CURRENT_PAGE.login.toPath();
      }
      if (authStateProvider.status == AuthStatus.authenticated &&
          routeToPath == CURRENT_PAGE.login.toPath()) {
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
