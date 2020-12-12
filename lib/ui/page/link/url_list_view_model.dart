import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final urlListViewModelProvider =
    ChangeNotifierProvider((ref) => UrlListViewModel());

class UrlListViewModel extends ChangeNotifier {
  UrlListViewModel();
}
