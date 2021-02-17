import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share/share.dart';

import '../../../../data/model/link.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../util/ext/async_snapshot.dart';
import '../../../../util/ext/string.dart';
import '../../../page/link/index_view_model.dart';
import 'link_list_item_shimmer.dart';

class LinkListItem extends HookWidget {
  LinkListItem({
    this.link,
    this.showEditLinkPage,
    Key key,
  }) : super(key: key);

  final Link link;

  final Function({
    @required BuildContext context,
    Link link,
  }) showEditLinkPage;

  @override
  Widget build(BuildContext context) {
    final indexViewModel = context.read(indexViewModelProvider);

    final snapshotDetail = useFuture(useMemoized(() {
      return indexViewModel.fetchLinkMetadata(link: link);
    }, [link.toString()]));

    Widget listTile;

    if (!snapshotDetail.isDone) {
      listTile = const LinkListItemShimmer();
    } else {
      final noImageIcon = Container(
        width: 80,
        height: 56,
        color: Colors.grey[200],
        child: Center(
          child: Assets.svgs.noImage.svg(
            width: 28,
            height: 28,
            fit: BoxFit.scaleDown,
          ),
        ),
      );

      final previewListItem = ListTile(
        title: Text(
          link.title,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        subtitle: Text(
          link.description,
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.caption,
        ),
        trailing: link.imageUrl == null
            ? noImageIcon
            : Image.network(
                link.imageUrl,
                width: 80,
                height: 56,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, url, error) => noImageIcon,
              ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
      );

      final contentListItem = ListTile(
        title: Text(
          link.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        subtitle: Text(
          link.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.caption,
        ),
        trailing: link.imageUrl == null
            ? noImageIcon
            : Image.network(
                link.imageUrl,
                width: 80,
                height: 56,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, url, error) => noImageIcon,
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
              Share.share(link.url);
            },
          ),
          CupertinoContextMenuAction(
            child: const Text('Edit'),
            trailingIcon: CupertinoIcons.pencil,
            onPressed: () {
              Navigator.pop(context);
              showEditLinkPage(
                context: context,
                link: link,
              );
            },
          ),
          CupertinoContextMenuAction(
            child: const Text(
              'Delete',
              style: TextStyle(color: CupertinoColors.destructiveRed),
            ),
            trailingIcon: CupertinoIcons.delete,
            onPressed: () {
              void doDelete() {
                final result = indexViewModel.deleteLink(link: link);
                result.then((value) {
                  value.when(
                    success: (data) {
                      indexViewModel.fetchLinks();
                    },
                    failure: (e) {
                      final snackBar = SnackBar(
                        content: const Text(
                            'Can‘t delete link. Retry in 5 seconds.'),
                        duration: const Duration(seconds: 5),
                        action: SnackBarAction(
                          label: 'RETRY',
                          onPressed: () {
                            doDelete();
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  );
                });
              }

              Navigator.pop(context);
              doDelete();
            },
          ),
        ],
        child: Material(
          child: contentListItem,
        ),
      );
    }
    return Card(
      child: listTile,
    );
  }
}
