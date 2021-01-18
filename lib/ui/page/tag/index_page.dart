import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:linkmark_app/data/model/tag.dart';
import 'package:linkmark_app/ui/component/box.dart';
import 'package:linkmark_app/ui/component/container_with_loading.dart';
import 'package:linkmark_app/ui/component/loading/loading_state_view_model.dart';
import 'package:linkmark_app/ui/page/tag/index_view_model.dart';
import 'package:linkmark_app/util/ext/async_snapshot.dart';

class TagIndexPage extends StatelessWidget {
  const TagIndexPage({Key key}) : super(key: key);

  Widget _buildTile(BuildContext context, double t, Tag tag) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final color = Color.lerp(Colors.white, Colors.grey.shade100, t);
    final elevation = lerpDouble(0, 8, t);

    final List<Widget> actions = [
      SlideAction(
        closeOnTap: true,
        color: Colors.redAccent,
        onTap: () {},
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Text(
                'Delete',
                style: textTheme.bodyText2.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return Slidable(
      enabled: true,
      actionPane: const SlidableBehindActionPane(),
      secondaryActions: actions,
      child: Box(
        height: 80,
        color: color,
        elevation: elevation,
        alignment: Alignment.center,
        // For testing different size item. You can comment this line
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListTile(
          title: Text(
            tag.name,
            style: textTheme.bodyText2.copyWith(
              fontSize: 16,
            ),
          ),
          trailing: const Handle(
            delay: Duration(milliseconds: 100),
            child: Icon(
              Icons.drag_handle,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read(tagIndexViewModelProvider);

    final hookBuilder = HookBuilder(builder: (context) {
      final result = useProvider(
          tagIndexViewModelProvider.select((value) => value.result));

      final snapshot = useFuture(useMemoized(() {
        return context
            .read(loadingStateProvider)
            .whileLoading(viewModel.fetchTags);
      }, [result.toString()]));

      if (!snapshot.isDone) return Container();

      return result.when(success: (_) {
        final hookBuilder = HookBuilder(builder: (context) {
          final tags = useProvider(
              tagIndexViewModelProvider.select((value) => value.tags));

          if (tags.isEmpty) {
            return Center(
              child: const Text('Empty Screen'),
            );
          }

          Widget buildReorderable({
            Tag tag,
            Widget Function(Widget tile) transitionBuilder,
          }) {
            return Reorderable(
              key: Key(tag.id),
              builder: (context, dragAnimation, inDrag) {
                final t = dragAnimation.value;
                final tile = _buildTile(context, t, tag);

                // If the item is in drag, only return the tile as the
                // SizeFadeTransition would clip the shadow.
                if (t > 0.0) {
                  return tile;
                }

                return transitionBuilder(
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      tile,
                      const Divider(height: 0),
                    ],
                  ),
                );
              },
            );
          }

          return ImplicitlyAnimatedReorderableList(
            items: tags,
            shrinkWrap: true,
            itemBuilder: (context, itemAnimation, tag, index) {
              return buildReorderable(
                tag: tag,
                transitionBuilder: (tile) {
                  return SizeFadeTransition(
                    sizeFraction: 0.7,
                    curve: Curves.easeInOut,
                    animation: itemAnimation,
                    child: tile,
                  );
                },
              );
            },
            areItemsTheSame: (oldItem, newItem) => oldItem == newItem,
            onReorderFinished: (movedTag, from, to, newItems) {},
            updateItemBuilder: (context, itemAnimation, tag) {
              return buildReorderable(
                tag: tag,
                transitionBuilder: (tile) {
                  return FadeTransition(
                    opacity: itemAnimation,
                    child: tile,
                  );
                },
              );
            },
          );
        });

        return hookBuilder;
      }, failure: (e) {
        return Center(
          child: Text('Error Screen: $e'),
        );
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Tag List'),
      ),
      body: ContainerWithLoading(
        child: hookBuilder,
      ),
    );
  }
}
