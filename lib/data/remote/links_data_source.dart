import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/link.dart';

abstract class LinksDataSource {
  Future<Map<String, Link>> getLinks();
  Future<void> createLink({@required String url});
}
