import 'package:fl_pages/constants/current_page.enum.dart';
import 'package:fl_pages/page/error.dart';
import 'package:fl_pages/pods/current_page.pod.dart';
import 'package:fl_pages/states/current_page.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoBackDummy extends ConsumerWidget {
  const GoBackDummy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // build up routes to the state
    ref.read(currentPagePod.notifier).update(
          CurrentPageState(
            CURRENT_PAGE.home,
            CURRENT_PAGE.home.toPath(),
          ),
        );
    ref.read(currentPagePod.notifier).update(
          CurrentPageState(
            CURRENT_PAGE.polygon,
            CURRENT_PAGE.polygon.toPath(),
          ),
        );

    // go back to previous route
    // TODO: find out how to fix 'No GoRouter found in context'
    // goBack(context: context, ref: ref);
    final currentPage = ref.read(currentPagePod);

    return Text(currentPage.last.path);
  }
}

void main() {
  group('router.helper', () {
    testWidgets('goBack() should return to the previous path ...',
        (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(path: CURRENT_PAGE.home.toPath()),
          GoRoute(path: CURRENT_PAGE.polygon.toPath()),
        ],
        errorPageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ErrorPage(state.error),
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            builder: (_, __) => const GoBackDummy(),
          ),
        ),
      );

      // TODO: find out how to attach routers to GoBackDummy
      // final _homeFinder = find.text(CURRENT_PAGE.home.toPath());

      // expect(_homeFinder, findsOneWidget);
    });
  });
}
