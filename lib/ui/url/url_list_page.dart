import 'package:flutter/material.dart';
import 'package:linkmark_app/ui/drawer/drawer_page.dart';

class UrlListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(),
    );
  }
}
