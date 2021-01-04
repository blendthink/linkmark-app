import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkmark_app/data/model/link.dart';
import 'package:linkmark_app/data/remote/links_data_source.dart';

class LinksDataSourceImpl implements LinksDataSource {
  LinksDataSourceImpl(
    this._firebaseAuth,
    this._firebaseDatabase,
  );

  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;

  @override
  Future<Map<String, Link>> getLinks() async {
    final uid = _firebaseAuth.currentUser.uid;

    final uidRef = _firebaseDatabase.reference().child('users').child(uid);

    final linksRef = uidRef.child('links');

    return linksRef.once().then(
      (snapshot) {
        final linksMap = Map<String, dynamic>.from(snapshot.value);
        return linksMap.map((key, value) {
          final linkMap = Map<String, dynamic>.from(value);
          return MapEntry(key, Link.fromJson(linkMap));
        });
      },
    ).catchError(
      (error) {
        debugPrint(error.toString());
        throw error;
      },
    );
  }

  @override
  Future<void> createLink({@required String url}) async {
    final uid = _firebaseAuth.currentUser.uid;

    final uidRef = _firebaseDatabase.reference().child('users').child(uid);

    final linksRef = uidRef.child('links');

    final newLinkRef = linksRef.push();
    final newLinkKey = newLinkRef.key;
    return newLinkRef.set({
      "id": newLinkKey,
      "url": url,
    });
  }
}
