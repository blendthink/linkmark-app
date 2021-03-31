import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../page/link/chosentags/chosen_tags_page.dart';
import '../search_app_bar_view_model.dart';
import 'tag_filter_view_model.dart';

class TagFilterWidget extends HookWidget implements PreferredSizeWidget {
  const TagFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final tagFilterViewModel = context.read(tagFilterViewModelProvider);

    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        children: [
          HookBuilder(builder: (context) {
            final isInSearchMode = useProvider(searchAppBarViewModelProvider
                .select((value) => value.isInSearchMode));

            final themeData = Theme.of(context);
            return IconButton(
              icon: const Icon(Icons.tag),
              color: isInSearchMode
                  ? themeData.primaryColor
                  : themeData.primaryIconTheme.color,
              onPressed: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => ChosenTagsPage(
                      initChosenTagIds: tagFilterViewModel.chosenTags
                          .map((e) => e.id)
                          .toList()),
                ).then((chosenTags) {
                  if (chosenTags == null) return;
                  tagFilterViewModel.updateChosenTags(chosenTags: chosenTags);
                });
              },
            );
          }),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: HookBuilder(
                builder: (context) {
                  final chosenTags = useProvider(tagFilterViewModelProvider
                      .select((value) => value.chosenTags));
                  return ListView.separated(
                    itemCount: chosenTags.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final tag = chosenTags[index];
                      return Chip(
                        label: Text(tag.name),
                        onDeleted: () {
                          tagFilterViewModel.removeChosenTag(tag: tag);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 4,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
