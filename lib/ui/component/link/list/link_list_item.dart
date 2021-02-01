import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../util/ext/async_snapshot.dart';
import '../../../../util/ext/string.dart';
import '../../../page/link/index_view_model.dart';
import 'link_list_item_shimmer.dart';

class LinkListItem extends HookWidget {
  LinkListItem({
    this.index,
    Key key,
  }) : super(key: key);

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

    final link = useProvider(indexViewModelProvider
        .select((value) => value.filteredLinks.dataOrThrow[index]));

    final snapshotDetail = useFuture(useMemoized(() {
      return indexViewModel.fetchLinkMetadata(index: index);
    }, [link.toString()]));

    Widget listTile;

    if (!snapshotDetail.isDone) {
      listTile = const LinkListItemShimmer();
    } else {
      final previewListItem = ListTile(
        title: Text(
          link.title.trimNewline(),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        subtitle: Text(
          link.description.trimNewline(),
          maxLines: 6,
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
                errorBuilder: (context, url, error) => const Icon(Icons.error),
              ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
      );

      final contentListItem = ListTile(
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
                errorBuilder: (context, url, error) => const Icon(Icons.error),
              ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
      );

      listTile = CupertinoContextMenu(
        previewBuilder: (context, animation, widget) {
          return Material(
            child: previewListItem,
          );
        },
        actions: [
          CupertinoContextMenuAction(
            child: const Text('Share'),
            trailingIcon: CupertinoIcons.share,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoContextMenuAction(
            child: const Text('Edit'),
            trailingIcon: CupertinoIcons.pencil,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoContextMenuAction(
            child: const Text(
              'Delete',
              style: TextStyle(color: CupertinoColors.destructiveRed),
            ),
            trailingIcon: CupertinoIcons.delete,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        child: Material(
          child: contentListItem,
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
