import 'package:linkmark_app/data/model/link.dart';
import 'package:linkmark_app/data/model/result.dart';

abstract class LinksRepository {
  Future<Result<Map<String, Link>>> getLinks();
}
