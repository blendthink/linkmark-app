import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/ui/component/container_with_loading.dart';
import 'package:linkmark_app/ui/component/link/list/link_list_item.dart';
import 'package:linkmark_app/ui/component/loading/loading_state_view_model.dart';
import 'package:linkmark_app/ui/page/link/index_view_model.dart';
import 'package:linkmark_app/util/ext/async_snapshot.dart';
import 'package:flutter/material.dart';
import 'package:linkmark_app/ui/component/appbar/search_app_bar.dart';
import 'package:linkmark_app/ui/page/drawer/drawer_page.dart';
import 'package:linkmark_app/ui/page/link/edit_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class IndexPage extends StatelessWidget {
  void _onTextChanged(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    final hookBuilder = HookBuilder(builder: (context) {
      final indexViewModel = context.read(indexViewModelProvider);
      final links =
          useProvider(indexViewModelProvider.select((value) => value.links));

      final snapshot = useFuture(useMemoized(() {
        return context
            .read(loadingStateProvider)
            .whileLoading(indexViewModel.fetchLinks);
      }, [links.toString()]));

      if (!snapshot.isDone) return Container();

      return links.when(success: (data) {
        if (data.isEmpty) {
          return const Text('Empty screen');
        }

        return RefreshIndicator(
          onRefresh: () async => indexViewModel.fetchLinks(),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return LinkListItem(
                linksMap: data,
                index: index,
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
        child: Icon(Icons.add),
        onPressed: () {
          showCupertinoModalBottomSheet(
            context: context,
            builder: (context) => const EditPage(),
          );
        },
      ),
      drawer: const DrawerPage(),
      appBar: SearchAppBar(
        onTextChanged: _onTextChanged,
      ),
      body: ContainerWithLoading(
        child: hookBuilder,
      ),
    );
  }
}
