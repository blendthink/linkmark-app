import 'package:flutter/material.dart';
import '../model/link.dart';
import '../model/result.dart';

abstract class LinksRepository {
  Future<Result<List<Link>>> getLinks();

  Future<Result<void>> createLink({@required String url});

  Future<Result<void>> deleteLink({@required String id});
}
