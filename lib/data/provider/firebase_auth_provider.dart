import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/all.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((_) => FirebaseAuth.instance);
