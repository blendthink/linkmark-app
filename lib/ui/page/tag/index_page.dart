import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/ui/component/container_with_loading.dart';
import 'package:linkmark_app/ui/component/loading/loading_state_view_model.dart';
import 'package:linkmark_app/ui/page/tag/index_view_model.dart';
import 'package:linkmark_app/util/ext/async_snapshot.dart';

class TagIndexPage extends StatelessWidget {
  const TagIndexPage({Key key}) : super(key: key);

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

          final children = tags.asMap().entries.map(
            (item) {
              final index = item.key;
              final tag = item.value;

              return Dismissible(
                key: Key(tag.id),
                child: ListTile(
                  title: Text(tag.name),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  viewModel.deleteTag(index: index);
                  if (direction == DismissDirection.endToStart) {
                    final snackBar = SnackBar(
                      content: const Text('削除しました'),
                      duration: const Duration(seconds: 1),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                background: Container(
                  padding: EdgeInsets.only(
                    right: 16,
                  ),
                  alignment: AlignmentDirectional.centerEnd,
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ).toList();

          return ReorderableListView(
            children: children,
            onReorder: (oldIndex, newIndex) {
              viewModel.reorder(oldIndex: oldIndex, newIndex: newIndex);
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
