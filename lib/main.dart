import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.router.dart';
import 'pods/auth.pod.dart';
import 'util/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  registerGoogleFontsLicense();
  await setWindowSizeForDesktop();
  await printAppVersion();
  setSystemUIOverlay();

  runApp(const ProviderScope(child: PagesApp()));
}

class PagesApp extends ConsumerStatefulWidget {
  const PagesApp({Key? key}) : super(key: key);

  @override
  PagesAppState createState() => PagesAppState();
}

class PagesAppState extends ConsumerState<PagesApp> with RestorationMixin {
  @override
  String get restorationId => 'wrapper';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (kDebugMode) {
      print('|.. oldBucket $oldBucket');
      print('\\.... initialRestore $initialRestore');
    }
    // * what to expect from oldBucket?
    // * wish to be able to update authState by using the bucket
    ref.read(authStateNotifierPod.notifier);
  }

  @override
  void initState() {
    super.initState();
    // * use ref.read() in the widget life-cycle methods
    final authStateProvider = ref.read(authStateNotifierPod);
    if (kDebugMode) {
      print('|.. authState: $authStateProvider');
    }
  }

  @override
  Widget build(BuildContext context) {
    // * go_router ought to have a Listenable to complete routing
    ref.listen(
      refreshListenableProvider,
      (_, __) => ref.watch(appRouter).refresh(),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      routeInformationParser: ref.watch(appRouter).routeInformationParser,
      routerDelegate: ref.watch(appRouter).routerDelegate,
      restorationScopeId: 'app',
    );
  }
}
