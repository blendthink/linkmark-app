import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/data/model/result.dart';
import 'package:linkmark_app/data/model/tag.dart';
import 'package:linkmark_app/data/provider/tags_repository_provider.dart';
import 'package:linkmark_app/data/repository/tags_repository.dart';

final tagFilterViewModelProvider = ChangeNotifierProvider(
    (ref) => TagFilterViewModel(ref.read(tagsRepositoryProvider)));

class TagFilterViewModel extends ChangeNotifier {
  TagFilterViewModel(this._repository);

  final TagsRepository _repository;

  Result<Map<String, Tag>> _tags;

  Result<Map<String, Tag>> get tags => _tags;

  Future<void> fetchTags() async {
    return _repository
        .getTags()
        .then((value) => _tags = value)
        .whenComplete(notifyListeners);
  }
}
