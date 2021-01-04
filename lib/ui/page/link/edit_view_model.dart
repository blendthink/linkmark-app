import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/data/model/result.dart';
import 'package:linkmark_app/data/provider/links_repository_provider.dart';
import 'package:linkmark_app/data/repository/links_repository.dart';

final editViewModelProvider = ChangeNotifierProvider(
    (ref) => EditViewModel(ref.read(linksRepositoryProvider)));

class EditViewModel extends ChangeNotifier {
  EditViewModel(this._repository);

  final LinksRepository _repository;

  Future<Result<void>> createLink({
    @required String url,
  }) {
    return _repository.createLink(url: url);
  }
}
