import 'package:flutter/material.dart';

enum CURRENT_PAGE { home, polygon }

extension CurrentPageExtension on CURRENT_PAGE {
  Icon toIcon() {
    switch (this) {
      case CURRENT_PAGE.home:
        return Icon(Icons.call);
      case CURRENT_PAGE.polygon:
        return Icon(Icons.camera);
    }
  }

  int toIndex() {
    switch (this) {
      case CURRENT_PAGE.home:
        return 0;
      case CURRENT_PAGE.polygon:
        return 1;
    }
  }

  String toLabel() {
    switch (this) {
      case CURRENT_PAGE.home:
        return 'Home';
      case CURRENT_PAGE.polygon:
        return 'Polygon';
    }
  }

  String toPath() {
    switch (this) {
      case CURRENT_PAGE.home:
        return '/';
      case CURRENT_PAGE.polygon:
        return '/polygon';
    }
  }

  String toTitle() {
    switch (this) {
      case CURRENT_PAGE.home:
        return 'Flutter Demo';
      case CURRENT_PAGE.polygon:
        return 'Polygon';
    }
  }
}
