import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    runApp(ProviderScope(child: App()));
  }, (error, stackTrace) {
    // TODO(okayama): FirebaseCrashlytics とかに送る
  });
}
