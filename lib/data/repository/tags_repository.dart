import 'package:linkmark_app/data/model/result.dart';
import 'package:linkmark_app/data/model/tag.dart';

abstract class TagsRepository {
  Future<Result<Map<String, Tag>>> getTags();
}
