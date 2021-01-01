import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/ui/component/appbar/tagfilter/tag_filter_view_model.dart';
import 'package:linkmark_app/util/ext/async_snapshot.dart';

class TagFilterWidget extends HookWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final tagFilterViewModel = context.read(tagFilterViewModelProvider);

    final tagsResult =
        useProvider(tagFilterViewModelProvider.select((value) => value.tags));

    final snapshot = useFuture(useMemoized(() {
      return tagFilterViewModel.fetchTags();
    }, [tagsResult.toString()]));

    if (!snapshot.isDone) return Container();

    return tagsResult.when(success: (data) {
      if (data.isEmpty) {
        return SizedBox(
          height: kToolbarHeight,
        );
      }

      return SizedBox(
        height: kToolbarHeight,
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: ListView.separated(
            itemCount: data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return HookBuilder(builder: (context) {
                final filterData = useProvider(tagFilterViewModelProvider
                    .select((value) => value.tags.dataOrThrow[index]));
                final tag = filterData.tag;

                return FilterChip(
                  selected: filterData.selected,
                  label: Text(tag.name),
                  onSelected: (bool value) {
                    tagFilterViewModel.updateTagSelected(
                      index: index,
                      selected: value,
                    );
                  },
                );
              });
            },
            separatorBuilder: (context, index) {
              return SizedBox(
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
