import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

import '../../../data/model/exception/app_exception.dart';
import '../../../data/model/exception/expected_exception.dart';
import '../../../data/model/tag.dart';
import '../../../util/ext/async_snapshot.dart';
import '../../component/box.dart';
import '../../component/container_with_loading.dart';
import '../../component/loading/loading_state_view_model.dart';
import 'index_view_model.dart';

class TagIndexPage extends StatelessWidget {
  const TagIndexPage({Key key}) : super(key: key);

  Widget _buildTile(BuildContext context, double t, Tag tag) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final color = Color.lerp(Colors.white, Colors.grey.shade100, t);
    final elevation = lerpDouble(0, 8, t);

    final actions = [
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

  void _onSubmitAddTagButton({
    @required BuildContext context,
    @required TagIndexViewModel viewModel,
  }) async {
    final result = await viewModel.createTag();
    if (result == null) {
      return;
    }

    if (result.isSuccess) {
      viewModel.textEditingController.clear();
      viewModel.fetchTags();
    } else {
      // AppError によって SnackBar を作り分ける
      SnackBar createSnackBar(AppException exception) {
        String snackBarContent;
        SnackBarAction snackBarAction;
        Duration snackBarDuration;
        if (exception is ExpectedException) {
          final message = exception.message;
          final solution = exception.solution;
          snackBarContent = '$message.\n$solution.';
          snackBarAction = null;
          snackBarDuration = const Duration(seconds: 3);
        } else {
          snackBarContent = 'Can‘t create tag. Retry in 5 seconds.';
          snackBarAction = SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              _onSubmitAddTagButton(context: context, viewModel: viewModel);
            },
          );
          snackBarDuration = const Duration(seconds: 5);
        }
        return SnackBar(
          margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 80.0),
          behavior: SnackBarBehavior.floating,
          content: Text(snackBarContent),
          duration: snackBarDuration,
          action: snackBarAction,
        );
      }

      final snackBar = createSnackBar(result.exception);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
            return const Center(
              child: Text('Empty Screen'),
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

    final footer = Material(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: CupertinoTextField(
          controller: viewModel.textEditingController,
          placeholder: "Enter Tag Name.",
          prefix: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.tag,
              color: Colors.blue,
            ),
          ),
          onSubmitted: (text) {
            _onSubmitAddTagButton(context: context, viewModel: viewModel);
          },
          suffixMode: OverlayVisibilityMode.always,
          suffix: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add_circle,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () {
              _onSubmitAddTagButton(context: context, viewModel: viewModel);
            },
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tag List'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ContainerWithLoading(
                child: hookBuilder,
              ),
            ),
            footer,
          ],
        ),
      ),
    );
  }
}
