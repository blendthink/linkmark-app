import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkmark_app/data/model/tag.dart';

abstract class TagsDataSource {
  Future<Map<String, Tag>> getTags();

  Future<void> createTag({
    @required String name,
    @required int order,
  });

  Future<void> updateTagName({
    @required String id,
    @required String name,
  });

  Future<void> updateTagsOrder({
    @required List<Tag> orderedTags,
  });

  Future<void> deleteTag({
    @required String id,
  });
}
