import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchAppBarViewModelProvider =
    ChangeNotifierProvider((ref) => SearchAppBarViewModel());

class SearchAppBarViewModel extends ChangeNotifier {
  SearchAppBarViewModel();

  bool _isInSearchMode = false;

  bool get isInSearchMode => _isInSearchMode;

  void updateIsSearchMode({@required bool isInSearchMode}) {
    _isInSearchMode = isInSearchMode;
    notifyListeners();
  }
}
