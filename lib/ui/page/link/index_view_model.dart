import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

import '../../../data/model/link.dart';
import '../../../data/model/result.dart';
import '../../../data/provider/links_repository_provider.dart';
import '../../../data/repository/links_repository.dart';
import '../../../util/ext/string.dart';
import '../../../util/logger.dart';

final indexViewModelProvider = ChangeNotifierProvider(
    (ref) => IndexViewModel(ref.read(linksRepositoryProvider)));

class IndexViewModel extends ChangeNotifier {
  IndexViewModel(this._repository);

  final LinksRepository _repository;

  String _filterText = '';
  List<String> _filterTagIds = List.empty();

  Result<void> _result;

  Result<void> get result => _result;

  List<Link> _links;

  List<Link> get filteredLinks {
    if (_links == null) return List.empty();

    List<Link> textFiltered;
    if (_filterText.isEmpty) {
      textFiltered = _links;
    } else {
      // 半角スペースでフィルターする文字を分割する
      final splitTexts = _filterText.split(' ');
      textFiltered = _links.where((link) {
        return splitTexts.every((element) =>
            link.title.contains(element) || link.description.contains(element));
      }).toList();
    }

    final tagFiltered = textFiltered.where((element) {
      final tagIds = element.tagIds;
      if (_filterTagIds.isEmpty) return true;
      if (tagIds == null) return false;
      return _filterTagIds.every(tagIds.contains);
    }).toList();
    return tagFiltered;
  }

  Future<void> fetchLinks() async {
    return _repository.getLinks().then((value) {
      _result = value.when(
        success: (data) {
          _links = data;
          return const Result.success();
        },
        failure: (e) => Result.failure(exception: e),
      );
    }).whenComplete(notifyListeners);
  }

  Future<void> fetchLinkMetadata({
    @required Link link,
  }) async {
    if (link.title.isNotEmpty || link.description.isNotEmpty) {
      return Future<void>.value();
    }

    return extract(link.url).then((value) {
      final newLink = link.copyWith.call(
        title: value.title.trimNewline(),
        description: value.description.trimNewline(),
        imageUrl: value.image,
      );
      final updateIndex = _links.indexOf(link);
      _links[updateIndex] = newLink;
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

  Future<Result<void>> deleteLink({
    @required Link link,
  }) {
    return _repository.deleteLink(id: link.id);
  }
}
