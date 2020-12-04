
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:linkmark_app/constants.dart';
import 'package:linkmark_app/ui/page/url/url_list_page.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Linkmark',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: UrlListPage(),
      routes: {
        Constants.pageUrlList: (context) => UrlListPage(),
      },
    );
  }
}
