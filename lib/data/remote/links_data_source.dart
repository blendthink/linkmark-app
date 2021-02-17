import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/link.dart';

abstract class LinksDataSource {
  Future<List<Link>> getLinks();

  Future<void> createLink({@required String url});

  Future<void> deleteLink({@required String id});
}
