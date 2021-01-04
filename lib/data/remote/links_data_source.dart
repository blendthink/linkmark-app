import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkmark_app/data/model/link.dart';

abstract class LinksDataSource {
  Future<Map<String, Link>> getLinks();
  Future<void> createLink({@required String url});
}
