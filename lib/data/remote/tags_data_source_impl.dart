import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../model/tag.dart';
import 'tags_data_source.dart';

class TagsDataSourceImpl implements TagsDataSource {
  TagsDataSourceImpl(
    this._firebaseAuth,
    this._firebaseDatabase,
  );

  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;

  DatabaseReference get _tagsRef {
    final uid = _firebaseAuth.currentUser.uid;
    final uidRef = _firebaseDatabase.reference().child('users').child(uid);
    return uidRef.child('tags');
  }

  @override
  Future<List<Tag>> getTags() async {
    return _tagsRef.orderByChild('order').once().then(
      (snapshot) {
        final tagsMap = Map<String, dynamic>.from(snapshot.value);
        final tags = tagsMap.entries
            .map((e) => Tag.fromJson(Map<String, dynamic>.from(e.value)))
            .toList()
              ..sort((a, b) => a.order.compareTo(b.order));
        return tags;
      },
    ).catchError(
      (error) {
        debugPrint(error.toString());
        throw error;
      },
    );
  }

  @override
  Future<void> createTag({
    @required String name,
    @required int order,
  }) {
    final newTagRef = _tagsRef.push();
    final newTagKey = newTagRef.key;
    final newTag = {
      "id": newTagKey,
      "name": name,
      "order": order,
    };
    return newTagRef.set(newTag).catchError(
      (error) {
        debugPrint(error.toString());
        throw error;
      },
    );
  }

  @override
  Future<void> deleteTag({
    @required String id,
  }) {
    return _tagsRef.child(id).remove().catchError(
      (error) {
        debugPrint(error.toString());
        throw error;
      },
    );
  }

  @override
  Future<void> updateTagName({
    @required String id,
    @required String name,
  }) {
    return _tagsRef.child(id).child("name").set(name).catchError(
      (error) {
        debugPrint(error.toString());
        throw error;
      },
    );
  }

  @override
  Future<void> updateTagsOrder({
    @required List<Tag> orderedTags,
  }) {
    final updateData = {};

    orderedTags.asMap().forEach((index, tag) {
      final tagId = tag.id;
      final tagMap = {
        "order": index,
      };
      updateData[tagId] = tagMap;
    });

    return _tagsRef.update(updateData).catchError(
      (error) {
        debugPrint(error.toString());
        throw error;
      },
    );
  }
}
