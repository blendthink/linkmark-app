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

  Result<List<TagFilterData>> _tags;

  Result<List<TagFilterData>> get tags => _tags;

  List<String> get filterTagIds {
    if (_tags == null) return List.empty();
    return _tags.dataOrThrow
        .where((element) => element.selected)
        .map((e) => e.tag.id)
        .toList();
  }

  Future<void> fetchTags() async {
    return _repository.getTags().then((value) {
      final list = value.dataOrThrow.map((tag) {
        return TagFilterData(selected: false, tag: tag);
      }).toList();
      _tags = Result.guard(() => list);
    }).whenComplete(notifyListeners);
  }

  Future<void> updateTagSelected({
    @required int index,
    @required bool selected,
  }) async {
    final newTagFilterData =
        _tags.dataOrThrow[index].copyWith.call(selected: selected);
    _tags.dataOrThrow[index] = newTagFilterData;
    notifyListeners();
  }
}
