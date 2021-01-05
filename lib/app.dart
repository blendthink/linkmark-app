import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:linkmark_app/constants.dart';
import 'package:linkmark_app/ui/page/auth/sign_in_page.dart';
import 'package:linkmark_app/ui/page/link/index_page.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    Widget home;
    if (user == null) {
      home = const SignInPage();
    } else {
      home = const IndexPage();
    }

    return GetMaterialApp(
      title: 'Linkmark',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: home,
      routes: {
        Constants.pageLinkIndex: (context) => const IndexPage(),
      },
    );
  }
}
