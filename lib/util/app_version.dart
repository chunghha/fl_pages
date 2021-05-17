import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';

final _logger = Logger();

void printAppVersion() async {
  if (!kIsWeb) {
    final _appInfo = await PackageInfo.fromPlatform();
    final _version = _appInfo.version;
    final _build = _appInfo.buildNumber;
    _logger.i('App Version: $_version+$_build');
  }
}
