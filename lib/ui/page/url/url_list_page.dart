import 'package:flutter/material.dart';
import 'package:linkmark_app/ui/page/drawer/drawer_page.dart';

const urls = [
  'https://qiita.com/popy1017/items/732229abc14e73933269',
  'https://google.com',
  'https://twitter.com',
];

class UrlListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text('Linkmark'),
        elevation: 0,
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
