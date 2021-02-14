import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/link.dart';
import 'links_data_source.dart';

class LinksDataSourceImpl implements LinksDataSource {
  LinksDataSourceImpl(
    this._firebaseAuth,
    this._firebaseDatabase,
  );

  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;

  DatabaseReference get _linksRef {
    final uid = _firebaseAuth.currentUser.uid;
    final uidRef = _firebaseDatabase.reference().child('users').child(uid);
    return uidRef.child('links');
  }

  @override
  Future<List<Link>> getLinks() async {
    return _linksRef.once().then(
      (snapshot) {
        final value = snapshot.value;
        if (value == null) return List<Link>.empty();

        final linksMap = Map<String, dynamic>.from(value);
        final links = linksMap.entries
            .map((e) => Link.fromJson(Map<String, dynamic>.from(e.value)))
            .toList();
        return links;
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
    final newLinkRef = _linksRef.push();
    final newLinkKey = newLinkRef.key;
    return newLinkRef.set({
      "id": newLinkKey,
      "url": url,
    });
  }
}
