import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/model/result.dart';
import '../../../../data/provider/tags_repository_provider.dart';
import '../../../../data/repository/tags_repository.dart';
import 'tag_filter_data.dart';

final tagFilterViewModelProvider = ChangeNotifierProvider(
    (ref) => TagFilterViewModel(ref.read(tagsRepositoryProvider)));

class TagFilterViewModel extends ChangeNotifier {
  TagFilterViewModel(this._repository);

  final TagsRepository _repository;

  Result<void> _result;

  Result<void> get result => _result;

  List<TagFilterData> _tags;

  List<TagFilterData> get tags => _tags;

  List<String> get filterTagIds {
    if (_tags == null) return List.empty();
    return _tags
        .where((element) => element.selected)
        .map((e) => e.tag.id)
        .toList();
  }

  Future<void> fetchTags() async {
    return _repository.getTags().then((value) {
      _result = value.when(
          success: (data) {
            _tags = data
                .map((tag) => TagFilterData(selected: false, tag: tag))
                .toList();
            return const Result.success();
          },
          failure: (e) => Result.failure(exception: e));
    }).whenComplete(notifyListeners);
  }

  Future<void> updateTagSelected({
    @required int index,
    @required bool selected,
  }) async {
    final newTagFilterData = _tags[index].copyWith.call(selected: selected);
    _tags[index] = newTagFilterData;
    notifyListeners();
  }
}
