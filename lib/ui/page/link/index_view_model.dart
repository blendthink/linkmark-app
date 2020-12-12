import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final indexViewModelProvider =
    ChangeNotifierProvider((ref) => IndexViewModel());

class IndexViewModel extends ChangeNotifier {
  IndexViewModel();
}
