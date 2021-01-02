import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/data/model/link.dart';
import 'package:linkmark_app/data/model/result.dart';
import 'package:linkmark_app/data/provider/links_repository_provider.dart';
import 'package:linkmark_app/data/repository/links_repository.dart';
import 'package:linkmark_app/util/logger.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

final indexViewModelProvider = ChangeNotifierProvider(
    (ref) => IndexViewModel(ref.read(linksRepositoryProvider)));

class IndexViewModel extends ChangeNotifier {
  IndexViewModel(this._repository);

  final LinksRepository _repository;

  List<String> _filterTagIds = List.empty();

  Result<List<Link>> _links;

  Result<List<Link>> get filteredLinks {
    if (_links == null) return Result.guard(() => List.empty());
    final filtered = _links.dataOrThrow.where((element) {
      final tagIds = element.tagIds;
      if (_filterTagIds.isEmpty) return true;
      if (tagIds == null) return false;
      return _filterTagIds.every((element) => tagIds.contains(element));
    }).toList();
    return Result.guard(() => filtered);
  }

  Future<void> fetchLinks() async {
    return _repository.getLinks().then((value) {
      final links = value.dataOrThrow.entries.map((e) => e.value).toList();
      _links = Result.guard(() => links);
    }).whenComplete(notifyListeners);
  }

  Future<void> fetchLinkMetadata({
    @required int index,
  }) async {
    final data = filteredLinks.dataOrThrow;
    final link = data[index];

    if (link.title.isNotEmpty || link.description.isNotEmpty) {
      return Future<void>.value();
    }

    return extract(link.url).then((value) {
      final newLink = link.copyWith.call(
        title: value.title,
        description: value.description,
        imageUrl: value.image,
      );
      final updateIndex = _links.dataOrThrow.indexOf(link);
      _links.dataOrThrow[updateIndex] = newLink;
    }).whenComplete(notifyListeners);
  }

  void updateFilterTagIds(List<String> filterTagIds) {
    logger.info('TagIds: $filterTagIds');
    _filterTagIds = filterTagIds;
    notifyListeners();
  }
}
