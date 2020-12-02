import 'package:flutter/material.dart';
import 'package:linkmark_app/ui/drawer/drawer_page.dart';

const urls = [
  'http://google.com',
  'http://twitter.com',
];

class UrlListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text('Linkmark'),
      ),
      body: ListView(
        children: urls.map(
          (url) {
            return ListTile(
              title: Text(url),
            );
          },
        ).toList(),
      ),
    );
  }
}
