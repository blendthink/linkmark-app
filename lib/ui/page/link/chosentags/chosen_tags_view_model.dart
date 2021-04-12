import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../data/model/result.dart';
import '../../../../data/model/tag.dart';
import '../../../../data/provider/tags_repository_provider.dart';
import '../../../../data/repository/tags_repository.dart';
import 'chosen_tag_data.dart';

final chosenTagsViewModelProvider = ChangeNotifierProvider(
    (ref) => ChosenTagsViewModel(ref.read(tagsRepositoryProvider)));

class ChosenTagsViewModel extends ChangeNotifier {
  ChosenTagsViewModel(this._repository);

  final TagsRepository _repository;

  late Result<void>? _result;

  Result<void>? get result => _result;

  late List<ChosenTagData> _chosenTagDataList;

  List<ChosenTagData> get chosenTagDataList =>
      _chosenTagDataList;

  List<Tag> get chosenTags => _chosenTagDataList
      .where((data) => data.isChosen)
      .map((data) => data.tag)
      .toList();

  Future<void> fetchTags({
    required List<String> initChosenTagIds,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _repository.getTags().then((value) {
      _result = value.when(
        success: (data) {
          _chosenTagDataList = data.map((tag) {
            final isChosen = initChosenTagIds.contains(tag.id);
            return ChosenTagData(tag: tag, isChosen: isChosen);
          }).toList();
          return const Result.success(data: null);
        },
        failure: (e) => Result.failure(exception: e),
      );
    }).whenComplete(notifyListeners);
  }

  void updateChoiceState({
    required int index,
    required bool isChosen,
  }) {
    final newTagData = _chosenTagDataList[index].copyWith.call(
          isChosen: isChosen,
        );
    _chosenTagDataList[index] = newTagData;
    notifyListeners();
  }
}
