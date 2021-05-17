import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../page/home.dart';
import '../page/polygons.dart';

class PolygonsLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('$home'),
          child: HomePage(),
        ),
        if (state.uri.pathSegments.contains('$polygons'))
          BeamPage(
            key: ValueKey('$polygons'),
            child: PolygonsPage(),
          ),
      ];

  @override
  List<String> get pathBlueprints => ['$polygons'];
}
