import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/provider/firebase_auth_provider.dart';

final drawerViewModelProvider = ChangeNotifierProvider(
    (ref) => DrawerViewModel(ref.read(firebaseAuthProvider)));

class DrawerViewModel extends ChangeNotifier {
  DrawerViewModel(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  User fetchCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
