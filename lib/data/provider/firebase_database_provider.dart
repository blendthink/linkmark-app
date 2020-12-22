import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/all.dart';

final firebaseDatabaseProvider =
    Provider<FirebaseDatabase>((_) => FirebaseDatabase.instance);
