import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/link.dart';
import '../../../data/model/result.dart';
import '../../../data/model/tag.dart';
import '../../../data/provider/links_repository_provider.dart';
import '../../../data/repository/links_repository.dart';
import '../../../util/logger.dart';

final indexViewModelProvider = ChangeNotifierProvider(
    (ref) => IndexViewModel(ref.read(linksRepositoryProvider)));

class IndexViewModel extends ChangeNotifier {
  IndexViewModel(this._repository);

  final LinksRepository _repository;

  String _filterText = '';

  Result<void>? _result;

  Result<void>? get result => _result;

  List<Link> _links = List.empty();

  List<Link> filteredLinks(List<Tag> chosenTags) {
    if (_links.isEmpty) return List.empty();

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

    // 選択したタグがなければそのまま返却
    final chosenTagIds = chosenTags.map((e) => e.id).toList();
    if (chosenTagIds.isEmpty) return textFiltered;

    final tagFiltered = textFiltered.where((element) {
      // tagIds が存在しない Link はリストから除外する
      final tagIds = element.tagIds;
      if (tagIds == null || tagIds.isEmpty) return false;

      // 選択したタグを全て含んでいる Link はリストに追加する
      return chosenTagIds.every(tagIds.contains);
    }).toList();
    return tagFiltered;
  }

  Future<void> fetchLinks() async {
    return _repository.getLinks().then((value) {
      _result = value.when(
        success: (data) {
          _links = data;
          return const Result.success(data: null);
        },
        failure: (e) => Result.failure(exception: e),
      );
    }).whenComplete(notifyListeners);
  }

  Future<void> fetchLinkMetadata({
    required Link link,
  }) async {
    if (link.title.isNotEmpty || link.description.isNotEmpty) {
      return Future<void>.value();
    }

    // TODO: metadata_fetch
    // return extract(link.url).then((value) {
    //   final newLink = link.copyWith.call(
    //     title: value.title.trimNewline(),
    //     description: value.description.trimNewline(),
    //     imageUrl: value.image,
    //   );
    //   final updateIndex = _links.indexOf(link);
    //   _links[updateIndex] = newLink;
    // }).whenComplete(notifyListeners);
    return Future<void>.value();
  }

  void updateFilterText(String filterText) {
    logger.info('FilterText: $filterText');
    _filterText = filterText;
    notifyListeners();
  }

  Future<Result<void>> deleteLink({
    required Link link,
  }) {
    return _repository.deleteLink(id: link.id);
  }
}
