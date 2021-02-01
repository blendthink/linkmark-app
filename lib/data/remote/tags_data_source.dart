import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/tag.dart';

abstract class TagsDataSource {
  Future<List<Tag>> getTags();

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
