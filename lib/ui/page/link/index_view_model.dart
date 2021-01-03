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

  String _filterText = '';
  List<String> _filterTagIds = List.empty();

  Result<List<Link>> _links;

  Result<List<Link>> get filteredLinks {
    if (_links == null) return Result.guard(() => List.empty());
    final originalLinks = _links.dataOrThrow;

    List<Link> textFiltered;
    if (_filterText.isEmpty) {
      textFiltered = originalLinks;
    } else {
      // 半角スペースでフィルターする文字を分割する
      final splitTexts = _filterText.split(' ');
      textFiltered = originalLinks.where((link) {
        return splitTexts.every((element) =>
            link.title.contains(element) || link.description.contains(element));
      }).toList();
    }

    final tagFiltered = textFiltered.where((element) {
      final tagIds = element.tagIds;
      if (_filterTagIds.isEmpty) return true;
      if (tagIds == null) return false;
      return _filterTagIds.every((element) => tagIds.contains(element));
    }).toList();
    return Result.guard(() => tagFiltered);
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

  void updateFilterText(String filterText) {
    logger.info('FilterText: $filterText');
    _filterText = filterText;
    notifyListeners();
  }

  void updateFilterTagIds(List<String> filterTagIds) {
    logger.info('FilterTagIds: $filterTagIds');
    _filterTagIds = filterTagIds;
    notifyListeners();
  }
}
