import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/exception/expected/tag/create_exception.dart';
import '../../../data/model/result.dart';
import '../../../data/model/tag.dart';
import '../../../data/provider/tags_repository_provider.dart';
import '../../../data/repository/tags_repository.dart';
import '../../../util/logger.dart';

final tagIndexViewModelProvider = ChangeNotifierProvider(
    (ref) => TagIndexViewModel(ref.read(tagsRepositoryProvider)));

class TagIndexViewModel extends ChangeNotifier {
  TagIndexViewModel(this._repository);

  final TagsRepository _repository;

  final _textEditingController = TextEditingController();

  TextEditingController get textEditingController => _textEditingController;

  late List<Tag> _tags;

  UnmodifiableListView<Tag> get tags => UnmodifiableListView(_tags);

  TagsState _state = TagsState.edited;

  TagsState get state => _state;

  late Result<void> _result;

  Result<void> get result => _result;

  Future<void> fetchTags() async {
    return _repository.getTags().then((value) {
      _result = value.when(
        success: (tags) {
          _tags = tags;
          return const Result.success();
        },
        failure: (e) {
          return Result.failure(exception: e);
        },
      );
    }).whenComplete(notifyListeners);
  }

  void reorder({
    required int oldIndex,
    required int newIndex,
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
    required String id,
    required String name,
  }) {
    return _repository
        .updateTagName(id: id, name: name)
        .whenComplete(notifyListeners);
  }

  Future<void> updateTagsOrder() {
    return _repository.updateTagsOrder(orderedTags: _tags);
  }

  void deleteTag({
    required int index,
  }) {
    _tags.removeAt(index);
    notifyListeners();
  }

  Future<Result<void>> createTag() {
    final text = _textEditingController.text;
    if (text.isEmpty) return Future.value();

    TagCreateException? extractException() {
      if (text.length > 20) {
        return const TagCreateException.nameTooLong();
      }
      if (_tags.any((tag) => tag.name.toLowerCase() == text.toLowerCase())) {
        return const TagCreateException.existsSameName();
      }
      return null;
    }

    final exception = extractException();
    if (exception != null) {
      return Future.value(Result.failure(exception: exception));
    }

    logger.info('Add Tag: $text');

    return _repository.createTag(name: text, order: _tags.length);
  }

  void updateState({
    required TagsState state,
  }) {
    _state = state;
    notifyListeners();
  }
}

enum TagsState {
  edited,
  editing,
  loading,
}
