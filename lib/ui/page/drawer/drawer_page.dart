import 'package:flutter/material.dart';
import 'package:linkmark_app/constants.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // TODO(okayama): 後から適切なものに修正する
          ListTile(
            leading: const Icon(Icons.web),
            title: Text(
              'URL',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () {
              // TODO(okayama): URL ページに遷移する
            },
          ),
          ListTile(
            leading: const Icon(Icons.tag),
            title: Text(
              'Tag',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () {
              // TODO(okayama): Tag ページに遷移する
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: Text(
              'OSS Licenses',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(Constants.pageLicenseIndex);
            },
          ),
        ],
      ),
    );
  }
}
