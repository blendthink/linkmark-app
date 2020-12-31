import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:linkmark_app/data/model/tag.dart';
import 'package:linkmark_app/data/remote/tags_data_source.dart';

class TagsDataSourceImpl implements TagsDataSource {
  TagsDataSourceImpl(
    this._firebaseAuth,
    this._firebaseDatabase,
  );

  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;

  @override
  Future<Map<String, Tag>> getTags() {
    final uid = _firebaseAuth.currentUser.uid;

    final uidRef = _firebaseDatabase.reference().child('users').child(uid);

    final tagsRef = uidRef.child('tags');

    return tagsRef.once().then(
      (snapshot) {
        final tagsMap = Map<String, dynamic>.from(snapshot.value);
        return tagsMap.map((key, value) {
          final tagMap = Map<String, dynamic>.from(value);
          return MapEntry(key, Tag.fromJson(tagMap));
        });
      },
    ).catchError(
      (error) {
        debugPrint(error.toString());
        throw error;
      },
    );
  }
}
