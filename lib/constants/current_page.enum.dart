import 'package:flutter/material.dart';

enum CURRENT_PAGE { home, polygon, form, login }

extension CurrentPageExtension on CURRENT_PAGE {
  Icon toIcon() {
    switch (this) {
      case CURRENT_PAGE.home:
        return const Icon(Icons.call);
      case CURRENT_PAGE.polygon:
        return const Icon(Icons.camera);
      case CURRENT_PAGE.form:
        return const Icon(Icons.checklist);
      case CURRENT_PAGE.login:
        return const Icon(Icons.login);
    }
  }

  int toIndex() {
    switch (this) {
      case CURRENT_PAGE.home:
        return 0;
      case CURRENT_PAGE.polygon:
        return 1;
      case CURRENT_PAGE.form:
        return 2;
      case CURRENT_PAGE.login:
        return -1;
    }
  }

  String toPath() {
    switch (this) {
      case CURRENT_PAGE.home:
        return '/';
      case CURRENT_PAGE.polygon:
        return '/polygon';
      case CURRENT_PAGE.form:
        return '/form';
      case CURRENT_PAGE.login:
        return '/login';
    }
  }

  String toTitle() {
    switch (this) {
      case CURRENT_PAGE.home:
        return 'Flutter Demo';
      case CURRENT_PAGE.polygon:
        return 'Polygon';
      case CURRENT_PAGE.form:
        return 'Form';
      case CURRENT_PAGE.login:
        return 'Login';
    }
  }
}
