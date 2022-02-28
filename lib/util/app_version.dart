import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';

final _logger = Logger();

Future<void> printAppVersion() async {
  if (!kIsWeb) {
    final appInfo = await PackageInfo.fromPlatform();
    final version = appInfo.version;
    final build = appInfo.buildNumber;
    _logger.i('App Version: $version+$build');
  }
}
