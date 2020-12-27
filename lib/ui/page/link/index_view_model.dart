import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/data/model/link.dart';
import 'package:linkmark_app/data/provider/links_repository_provider.dart';
import 'package:linkmark_app/data/repository/links_repository.dart';
import 'package:linkmark_app/data/model/result.dart';

final indexViewModelProvider = ChangeNotifierProvider(
    (ref) => IndexViewModel(ref.read(linksRepositoryProvider)));

class IndexViewModel extends ChangeNotifier {
  IndexViewModel(this._repository);

  final LinksRepository _repository;

  Result<List<Link>> _links;

  Result<List<Link>> get links => _links;

  Future<void> fetchLinks() async {
    return _repository
        .getLinks()
        .then((value) => _links = value)
        .whenComplete(notifyListeners);
  }
}
