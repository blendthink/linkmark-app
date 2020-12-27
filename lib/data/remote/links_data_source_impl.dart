import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
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
  Future<List<Link>> getLinks() async {
    final uid = _firebaseAuth.currentUser.uid;

    final uidRef = _firebaseDatabase.reference().child('users').child(uid);

    final linksRef = uidRef.child('links');

    return linksRef.once().then(
      (snapshot) {
        final linksMap = Map<String, dynamic>.from(snapshot.value);
        return linksMap.values.map((e) => Link.fromJson(e)).toList();
      },
    ).catchError(
      (error) {
        debugPrint(error.toString());
        throw error;
      },
    );
  }
}
