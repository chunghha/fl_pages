import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'location/router.dart';
import 'util/index.dart';

void main() async {
  registerGoogleFontsLicense();
  setWindowSizeForDesktop();
  printAppVersion();
  setSystemUIOverlay();

  runApp(ProviderScope(child: PagesApp()));
}

class PagesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Pages Demo',
      theme: getAppTheme(context),
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      backButtonDispatcher:
          BeamerBackButtonDispatcher(delegate: routerDelegate),
    );
  }
}
