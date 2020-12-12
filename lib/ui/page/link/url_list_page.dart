import 'package:flutter/material.dart';
import 'package:linkmark_app/ui/component/appbar/search_app_bar.dart';
import 'package:linkmark_app/ui/page/drawer/drawer_page.dart';
import 'package:linkmark_app/ui/page/link/edit_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

final linkDataList = [
  LinkData(
    url: 'https://qiita.com/warahiko/items/3676f1164f4619e8debc',
    title: 'OpenAPI Generator でAndroid コードを自動生成する - Qiita',
    description:
        'The OpenAPI Specification (OAS　OAS はHTTP API の仕様を記述するためのフォーマットです。主な内容は以下のように、OAS のバージョン番号記述するAPI のバージョン番号、タイ...',
    imageUrl:
        'https://qiita-user-contents.imgix.net/https%3A%2F%2Fcdn.qiita.com%2Fassets%2Fpublic%2Farticle-ogp-background-1150d8b18a7c15795b701a55ae908f94.png?ixlib=rb-1.2.2&w=1200&mark=https%3A%2F%2Fqiita-user-contents.imgix.net%2F~text%3Fixlib%3Drb-1.2.2%26w%3D840%26h%3D380%26txt%3DOpenAPI%2520Generator%2520%25E3%2581%25A7Android%2520%25E3%2582%25B3%25E3%2583%25BC%25E3%2583%2589%25E3%2582%2592%25E8%2587%25AA%25E5%258B%2595%25E7%2594%259F%25E6%2588%2590%25E3%2581%2599%25E3%2582%258B%26txt-color%3D%2523333%26txt-font%3DHiragino%2520Sans%2520W6%26txt-size%3D54%26txt-clip%3Dellipsis%26txt-align%3Dcenter%252Cmiddle%26s%3D34cc06e9da063a0e2ea44de3fca53cc4&mark-align=center%2Cmiddle&blend=https%3A%2F%2Fqiita-user-contents.imgix.net%2F~text%3Fixlib%3Drb-1.2.2%26w%3D840%26h%3D500%26txt%3D%2540warahiko%26txt-color%3D%2523333%26txt-font%3DHiragino%2520Sans%2520W6%26txt-size%3D45%26txt-align%3Dright%252Cbottom%26s%3D3f940296ed800c26178432a7ca91cf9e&blend-align=center%2Cmiddle&blend-mode=normal&s=6b3cf66e6d1ba19e699571dc6461c31d',
  ),
  LinkData(
    url: 'https://github.com/OpenAPITools/openapi-generator/pull/6916',
    title:
        '[Kotlin][Client] Added Kotlinx Serialization for JVM/Retrofit2 by kuFEAR · Pull Request #6916 · OpenAPITools/openapi-generator',
    description:
        'Added supporting for Kotlinx.serialization 1.0.0 on JVM with base set of JVM type serialize adapters PR checklist Read the contribution guidelines. If contributing template-only or documentatio...',
    imageUrl: 'https://avatars1.githubusercontent.com/u/37325267?s=400&v=4',
  ),
];

class LinkData {
  final String url;
  final String title;
  final String description;
  final String imageUrl;

  LinkData({
    @required this.url,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
  });
}

class UrlListPage extends StatelessWidget {
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showCupertinoModalBottomSheet(
            context: context,
            builder: (context) => EditPage(),
          );
        },
      ),
      drawer: const DrawerPage(),
      appBar: SearchAppBar(
        onTextChanged: _onTextChanged,
      ),
      body: ListView(
        children: linkDataList.map(
          (linkData) {
            final listTile = ListTile(
              title: Text(
                linkData.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              subtitle: Text(
                linkData.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              ),
              trailing: Image.network(
                linkData.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.fitHeight,
              ),
            );

            return Card(
              child: InkWell(
                onTap: () {
                  _launchURL(url: linkData.url);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: listTile,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
