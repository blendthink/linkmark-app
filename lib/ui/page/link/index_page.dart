import 'package:linkmark_app/util/ext/string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:linkmark_app/ui/component/appbar/search_app_bar.dart';
import 'package:linkmark_app/ui/page/drawer/drawer_page.dart';
import 'package:linkmark_app/ui/page/link/edit_page.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class IndexPage extends StatelessWidget {
  final _databaseReference = FirebaseDatabase.instance.reference();

  void _onTextChanged(String text) {
    print(text);
  }

  _launchURL({@required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;

    final uidRef = _databaseReference.child('users').child(uid);
    uidRef.push();

    final linksRef = uidRef.child('links');

    final animatedList = FirebaseAnimatedList(
      query: linksRef.orderByKey(),
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (_, snapshot, animation, x) {
        // TODO(okayama): model に変換する
        final linkData = snapshot.value;
        final url = linkData['url'];
        // final linkId = snapshot.key;
        // final tags = linkData['tags'] ?? [];

        return FutureBuilder(
          future: extract(url),
          builder: (context, snapshot) {
            Widget listChild;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                listChild = Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  listChild = Center(
                    child: Text(snapshot.error.toString()),
                  );
                  break;
                }

                if (!snapshot.hasData) {
                  listChild = Center(
                    child: Text('データが存在しません'),
                  );
                  break;
                }

                final linkData = snapshot.data;
                final String title = linkData.title;
                final String description = linkData.description;
                final String imageUrl = linkData.image;
                listChild = ListTile(
                  title: Text(
                    title.trimNewline(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  subtitle: Text(
                    description.trimNewline(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  trailing: imageUrl == null
                      ? null
                      : Image.network(
                          imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.fitHeight,
                        ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                );
                break;
              default:
                break;
            }

            return Card(
              child: InkWell(
                onTap: () {
                  _launchURL(url: url);
                },
                child: SizedBox(
                  child: listChild,
                ),
              ),
            );
          },
        );
      },
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showCupertinoModalBottomSheet(
            context: context,
            builder: (context) => const EditPage(),
          );
        },
      ),
      drawer: const DrawerPage(),
      appBar: SearchAppBar(
        onTextChanged: _onTextChanged,
      ),
      body: animatedList,
    );
  }
}
