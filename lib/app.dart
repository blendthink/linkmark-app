import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'constants.dart';
import 'ui/page/auth/sign_in_page.dart';
import 'ui/page/link/index_page.dart';
import 'ui/page/tag/index_page.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    Widget home;
    if (user == null) {
      home = const SignInPage();
    } else {
      home = const IndexPage();
    }

    return GetMaterialApp(
      title: 'Linkmark',
      theme: ThemeData().copyWith(
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey.shade300,
        ),
      ),
      darkTheme: ThemeData.dark(),
      home: home,
      routes: {
        Constants.pageLinkIndex: (context) => const IndexPage(),
        Constants.pageTagIndex: (context) => const TagIndexPage(),
      },
    );
  }
}
