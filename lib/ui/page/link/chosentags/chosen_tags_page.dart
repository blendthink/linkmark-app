import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/model/tag.dart';
import '../../../../util/ext/async_snapshot.dart';
import '../../../../util/ext/list.dart';
import '../../../component/container_with_loading.dart';
import '../../../component/loading/loading_state_view_model.dart';
import 'chosen_tags_view_model.dart';

class ChosenTagsPage extends StatelessWidget {
  final List<String> initChosenTagIds;

  ChosenTagsPage({this.initChosenTagIds, Key key}) : super(key: key);

  void _onPop({
    @required BuildContext context,
    List<Tag> chosenTags,
  }) {
    Navigator.of(context).pop(chosenTags);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read(chosenTagsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            _onPop(context: context);
          },
        ),
        actions: [
          HookBuilder(builder: (context) {
            final chosenTagDataList = useProvider(chosenTagsViewModelProvider
                .select((value) => value.chosenTagDataList));

            if (chosenTagDataList.isEmpty) {
              return Container();
            } else {
              return IconButton(
                icon: const Icon(Icons.done),
                onPressed: () {
                  _onPop(
                    context: context,
                    chosenTags: viewModel.chosenTags,
                  );
                },
              );
            }
          }),
        ],
        title: const Text('Choose Tags'),
      ),
      body: ContainerWithLoading(
        child: HookBuilder(
          builder: (context) {
            final result = useProvider(
                chosenTagsViewModelProvider.select((value) => value.result));

            final chosenTagDataList = useProvider(chosenTagsViewModelProvider
                .select((value) => value.chosenTagDataList));

            final snapshot = useFuture(useMemoized(() {
              return context.read(loadingStateProvider).whileLoading(() =>
                  viewModel.fetchTags(initChosenTagIds: initChosenTagIds));
            }));

            if (!snapshot.isDone) return Container();

            return result.when(
              success: (_) {
                if (chosenTagDataList.isEmpty) {
                  return const Center(
                    child: Text('Empty screen'),
                  );
                }

                final filterChips = chosenTagDataList.indexedMap((index, data) {
                  return HookBuilder(builder: (context) {
                    final tagData = useProvider(chosenTagsViewModelProvider
                        .select((value) => value.chosenTagDataList[index]));

                    return FilterChip(
                        label: Text(tagData.tag.name),
                        selected: tagData.isChosen,
                        onSelected: (value) {
                          viewModel.updateChoiceState(
                            index: index,
                            isChosen: value,
                          );
                        });
                  });
                }).toList();

                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 4,
                    children: filterChips,
                  ),
                );
              },
              failure: (e) => Center(
                child: Text('Error Screen: $e'),
              ),
            );
          },
        ),
      ),
    );
  }
}
