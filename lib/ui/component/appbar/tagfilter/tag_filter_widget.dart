import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../util/ext/async_snapshot.dart';
import '../../../page/link/index_view_model.dart';
import 'tag_filter_view_model.dart';

class TagFilterWidget extends HookWidget implements PreferredSizeWidget {
  const TagFilterWidget({
    Key key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final indexViewModel = context.read(indexViewModelProvider);
    final tagFilterViewModel = context.read(tagFilterViewModelProvider);

    final result =
        useProvider(tagFilterViewModelProvider.select((value) => value.result));
    final tags =
        useProvider(tagFilterViewModelProvider.select((value) => value.tags));

    final snapshot = useFuture(
        useMemoized(tagFilterViewModel.fetchTags, [result.toString()]));

    if (!snapshot.isDone) return Container();

    return result.when(success: (data) {
      if (tags.isEmpty) {
        return const SizedBox(
          height: kToolbarHeight,
        );
      }

      return SizedBox(
        height: kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView.separated(
            itemCount: tags.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return HookBuilder(builder: (context) {
                final filterData = useProvider(tagFilterViewModelProvider
                    .select((value) => value.tags[index]));
                final tag = filterData.tag;

                return FilterChip(
                  selected: filterData.selected,
                  label: Text(tag.name),
                  onSelected: (value) {
                    tagFilterViewModel.updateTagSelected(
                      index: index,
                      selected: value,
                    );
                    final newFilterTagIds = tagFilterViewModel.filterTagIds;
                    indexViewModel.updateFilterTagIds(newFilterTagIds);
                  },
                );
              });
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 4,
              );
            },
          ),
        ),
      );
    }, failure: (e) {
      return Text('Error Screen: $e');
    });
  }
}
