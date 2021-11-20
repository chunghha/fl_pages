import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

ThemeData getAppTheme(BuildContext context) {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: bgColor,
    appBarTheme: AppBarTheme(
      toolbarTextStyle:
          GoogleFonts.ibmPlexSerifTextTheme(Theme.of(context).textTheme)
              .apply(
                bodyColor: appbarTextColor,
                fontSizeFactor: 1.25,
              )
              .bodyText2,
      titleTextStyle:
          GoogleFonts.ibmPlexSerifTextTheme(Theme.of(context).textTheme)
              .apply(
                bodyColor: appbarTextColor,
                fontSizeFactor: 1.25,
              )
              .headline6,
    ),
    iconTheme: IconThemeData(
      color: Colors.indigo[400],
    ),
    textTheme: GoogleFonts.ibmPlexSansTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: textColor),
    canvasColor: canvasColor,
  );
}
