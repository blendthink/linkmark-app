import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/data/model/link.dart';
import 'package:linkmark_app/data/provider/links_repository_provider.dart';
import 'package:linkmark_app/data/repository/links_repository.dart';
import 'package:linkmark_app/data/model/result.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

final indexViewModelProvider = ChangeNotifierProvider(
    (ref) => IndexViewModel(ref.read(linksRepositoryProvider)));

class IndexViewModel extends ChangeNotifier {
  IndexViewModel(this._repository);

  final LinksRepository _repository;

  Result<Map<String, Link>> _links;

  Result<Map<String, Link>> get links => _links;

  Future<void> fetchLinks() async {
    return _repository
        .getLinks()
        .then((value) => _links = value)
        .whenComplete(notifyListeners);
  }

  Future<void> fetchLinkMetadata({
    @required int index,
  }) async {
    final data = _links.dataOrThrow;
    final linkMap = data.entries.elementAt(index);
    final key = linkMap.key;
    final link = linkMap.value;

    return extract(link.url).then((value) {
      final newLink = link.copyWith.call(
        title: value.title,
        description: value.description,
        imageUrl: value.image,
      );
      _links.dataOrThrow[key] = newLink;
    }).whenComplete(notifyListeners);
  }
}
