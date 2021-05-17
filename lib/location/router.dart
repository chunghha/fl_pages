import 'package:beamer/beamer.dart';

import 'home_location.dart';
import 'polygons_location.dart';

final routerDelegate = BeamerDelegate(
  locationBuilder: BeamerLocationBuilder(
    beamLocations: [
      HomeLocation(),
      PolygonsLocation(),
    ],
  ),
);
