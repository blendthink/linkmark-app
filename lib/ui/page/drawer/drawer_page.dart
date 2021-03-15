import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants.dart';
import 'drawer_view_model.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerViewModel = context.read(drawerViewModelProvider);

    final currentUser = drawerViewModel.fetchCurrentUser();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(currentUser.displayName),
            accountEmail: Text(currentUser.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                currentUser.photoURL,
              ),
              radius: 25,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.tag),
            title: Text(
              'Tags',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(Constants.pageTagIndex);
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: Text(
              'Licenses',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () {
              showLicensePage(context: context);
            },
          ),
        ],
      ),
    );
  }
}
