import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseDatabaseProvider =
    Provider<FirebaseDatabase>((_) => FirebaseDatabase.instance);
