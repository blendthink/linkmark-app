import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Flavor { development, production }

@immutable
class Constants {
  const Constants();

  factory Constants.of() {
    if (_instance != null) {
      return _instance!;
    }

    final flavor = EnumToString.fromString(
      Flavor.values,
      const String.fromEnvironment('FLAVOR'),
    );

    switch (flavor) {
      case Flavor.development:
        _instance = Constants._dev();
        break;
      case Flavor.production:
      default:
        _instance = Constants._prd();
    }
    return _instance!;
  }

  factory Constants._dev() {
    return const Constants();
  }

  factory Constants._prd() {
    return const Constants();
  }

  // Routing name
  static const String pageLinkIndex = '/link_index';
  static const String pageTagIndex = '/tag_index';

  static const bool isDebugMode = kDebugMode;

  static Constants? _instance;
}
