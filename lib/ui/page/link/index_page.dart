import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/data/model/link.dart';
import 'package:linkmark_app/ui/component/container_with_loading.dart';
import 'package:linkmark_app/ui/component/loading/loading_state_view_model.dart';
import 'package:linkmark_app/ui/page/link/index_view_model.dart';
import 'package:linkmark_app/util/ext/async_snapshot.dart';
import 'package:linkmark_app/util/ext/string.dart';
import 'package:flutter/material.dart';
import 'package:linkmark_app/ui/component/appbar/search_app_bar.dart';
import 'package:linkmark_app/ui/page/drawer/drawer_page.dart';
import 'package:linkmark_app/ui/page/link/edit_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class IndexPage extends StatelessWidget {
  void _onTextChanged(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    final hookBuilder = HookBuilder(builder: (context) {
      final indexViewModel = context.read(indexViewModelProvider);
      final links =
          useProvider(indexViewModelProvider.select((value) => value.links));

      final snapshot = useFuture(useMemoized(() {
        return context
            .read(loadingStateProvider)
            .whileLoading(indexViewModel.fetchLinks);
      }, [links.toString()]));

      if (!snapshot.isDone) return Container();

      return links.when(success: (data) {
        if (data.isEmpty) {
          return const Text('Empty screen');
        }

        return RefreshIndicator(
          onRefresh: () async => indexViewModel.fetchLinks(),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return LinkItem(
                linksMap: data,
                index: index,
              );
            },
          ),
        );
      }, failure: (e) {
        return Text('Error Screen: $e');
      });
    });

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
      body: ContainerWithLoading(
        child: hookBuilder,
      ),
    );
  }
}

class LinkItem extends HookWidget {
  LinkItem({
    this.linksMap,
    this.index,
    Key key,
  }) : super(key: key);

  final Map<String, Link> linksMap;
  final int index;

  _launchURL({@required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final indexViewModel = context.read(indexViewModelProvider);

    final linkMap = linksMap.entries.elementAt(index);
    final link = linkMap.value;

    final snapshotDetail = useFuture(useMemoized(() {
      return indexViewModel.fetchLinkMetadata(index: index);
    }, [link.toString()]));

    Widget listTile;

    if (!snapshotDetail.isDone) {
      final screenWidth = MediaQuery.of(context).size.width;
      final textWidth = screenWidth - (80 + 48);

      const gapTextVerticalTitle = const Gap(4);
      final containerInfinityWidthTitle = Container(
        width: double.infinity,
        height: 12.0,
        color: Colors.white,
      );
      final containerHalfwayWidthTitle = Container(
        width: textWidth * 2 / 5,
        height: 12.0,
        color: Colors.white,
      );

      const gapTextVerticalSubTitle = const Gap(2);
      final containerInfinityWidthSubTitle = Container(
        width: double.infinity,
        height: 8.0,
        color: Colors.white,
      );
      final containerHalfwayWidthSubTitle = Container(
        width: textWidth / 5,
        height: 8.0,
        color: Colors.white,
      );

      listTile = Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    containerInfinityWidthTitle,
                    gapTextVerticalTitle,
                    containerHalfwayWidthTitle,
                    gapTextVerticalTitle,
                    containerInfinityWidthSubTitle,
                    gapTextVerticalSubTitle,
                    containerInfinityWidthSubTitle,
                    gapTextVerticalSubTitle,
                    containerHalfwayWidthSubTitle,
                  ],
                ),
              ),
              const Gap(16),
              Container(
                width: 80.0,
                height: 56.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    } else {
      listTile = ListTile(
        title: Text(
          link.title.trimNewline(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        subtitle: Text(
          link.description.trimNewline(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.caption,
        ),
        trailing: link.imageUrl == null
            ? null
            : Image.network(
                link.imageUrl,
                width: 80,
                height: 56,
                fit: BoxFit.fitHeight,
              ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
      );
    }
    return Card(
      child: InkWell(
        onTap: () {
          _launchURL(url: link.url);
        },
        child: listTile,
      ),
    );
  }
}
