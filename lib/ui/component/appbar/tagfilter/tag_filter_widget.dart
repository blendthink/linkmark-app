import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../util/ext/async_snapshot.dart';
import '../../../page/link/chosentags/chosen_tags_page.dart';
import 'tag_filter_view_model.dart';

class TagFilterWidget extends HookWidget implements PreferredSizeWidget {
  const TagFilterWidget({
    Key key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.tag),
              onPressed: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      ChosenTagsPage(initChosenTagIds: List.empty()),
                );
              },
            ),
            Flexible(
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

                      return Chip(
                        label: Text(tag.name),
                        onDeleted: () {},
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
            ),
          ],
        ),
      );
    }, failure: (e) {
      return Text('Error Screen: $e');
    });
  }
}
