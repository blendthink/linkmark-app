import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/data/model/result.dart';
import 'package:linkmark_app/data/model/tag.dart';
import 'package:linkmark_app/data/provider/tags_repository_provider.dart';
import 'package:linkmark_app/data/repository/tags_repository.dart';

final tagIndexViewModelProvider = ChangeNotifierProvider(
    (ref) => TagIndexViewModel(ref.read(tagsRepositoryProvider)));

class TagIndexViewModel extends ChangeNotifier {
  TagIndexViewModel(this._repository);

  final TagsRepository _repository;

  List<Tag> _tags;

  UnmodifiableListView<Tag> get tags => UnmodifiableListView(_tags);

  Result<void> _result;

  Result<void> get result => _result;

  Future<void> fetchTags() async {
    return _repository.getTags().then((value) {
      value.when(
        success: (tags) {
          _result = Result.success();
          _tags = tags.entries.map((e) => e.value).toList();
        },
        failure: (error) {
          _result = Result.failure(error: error);
        },
      );
    }).whenComplete(notifyListeners);
  }

  void reorder({
    @required int oldIndex,
    @required int newIndex,
  }) {
    int insertIndex;
    if (newIndex > oldIndex) {
      insertIndex = newIndex - 1;
    } else {
      insertIndex = newIndex;
    }

    final item = _tags.removeAt(oldIndex);
    _tags.insert(insertIndex, item);

    notifyListeners();
  }

  Future<void> updateTagName({
    @required String id,
    @required String name,
  }) {
    return _repository
        .updateTagName(id: id, name: name)
        .whenComplete(notifyListeners);
  }

  Future<void> updateTagsOrder() {
    return _repository.updateTagsOrder(orderedTags: _tags);
  }
}
