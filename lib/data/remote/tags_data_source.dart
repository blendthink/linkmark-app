import 'package:linkmark_app/data/model/tag.dart';

abstract class TagsDataSource {
  Future<Map<String, Tag>> getTags();
}
