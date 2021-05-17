import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../page/home.dart';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('$home'),
          child: HomePage(),
        ),
      ];

  @override
  List<String> get pathBlueprints => ['$home'];
}
