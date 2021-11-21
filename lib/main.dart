import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.router.dart';
import 'util/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  registerGoogleFontsLicense();
  setWindowSizeForDesktop();
  printAppVersion();
  setSystemUIOverlay();

  runApp(ProviderScope(child: PagesApp()));
}

class PagesApp extends HookConsumerWidget {
  const PagesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * go_router ought to have a Listenable to complete routing
    ref.listen(
      refreshListenableProvider,
      (_, __) => ref.watch(appRouter).refresh(),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: ref.watch(appRouter).routeInformationParser,
      routerDelegate: ref.watch(appRouter).routerDelegate,
    );
  }
}
