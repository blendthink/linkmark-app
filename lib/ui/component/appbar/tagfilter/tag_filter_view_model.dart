import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/model/tag.dart';

final tagFilterViewModelProvider =
    ChangeNotifierProvider((ref) => TagFilterViewModel());

class TagFilterViewModel extends ChangeNotifier {
  TagFilterViewModel();

  late List<Tag> _chosenTags;

  List<Tag> get chosenTags => _chosenTags ?? List.empty();

  void updateChosenTags({
    required List<Tag> chosenTags,
  }) {
    _chosenTags = chosenTags;
    notifyListeners();
  }

  void removeChosenTag({
    required Tag tag,
  }) async {
    _chosenTags.removeWhere((element) => element.id == tag.id);
    _chosenTags = List.of(_chosenTags);
    notifyListeners();
  }
}
