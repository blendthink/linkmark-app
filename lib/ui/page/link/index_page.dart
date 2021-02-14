import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../util/ext/async_snapshot.dart';
import '../../component/appbar/search_app_bar.dart';
import '../../component/container_with_loading.dart';
import '../../component/link/list/link_list_item.dart';
import '../../component/loading/loading_state_view_model.dart';
import '../drawer/drawer_page.dart';
import 'edit_page.dart';
import 'index_view_model.dart';

class IndexPage extends StatelessWidget {
  const IndexPage() : super();

  @override
  Widget build(BuildContext context) {
    final indexViewModel = context.read(indexViewModelProvider);

    final hookBuilder = HookBuilder(builder: (context) {
      final result =
          useProvider(indexViewModelProvider.select((value) => value.result));
      final links = useProvider(
          indexViewModelProvider.select((value) => value.filteredLinks));

      final snapshot = useFuture(useMemoized(() {
        return context
            .read(loadingStateProvider)
            .whileLoading(indexViewModel.fetchLinks);
      }));

      if (!snapshot.isDone) return Container();

      return result.when(success: (_) {
        if (links.isEmpty) {
          return const Text('Empty screen');
        }

        return RefreshIndicator(
          onRefresh: () async => indexViewModel.fetchLinks(),
          child: ListView.builder(
            itemCount: links.length,
            itemBuilder: (_, index) {
              return LinkListItem(
                link: links[index],
              );
            },
          ),
        );
      }, failure: (e) {
        return Text('Error Screen: $e');
      });
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showCupertinoModalBottomSheet(
            context: context,
            builder: (context) => const EditPage(),
          ).then((existsUpdate) {
            if (existsUpdate) {
              indexViewModel.fetchLinks();
            }
          });
        },
      ),
      drawer: const DrawerPage(),
      appBar: const SearchAppBar(),
      body: ContainerWithLoading(
        child: hookBuilder,
      ),
    );
  }
}
