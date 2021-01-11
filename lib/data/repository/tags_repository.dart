import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkmark_app/data/model/result.dart';
import 'package:linkmark_app/data/model/tag.dart';

abstract class TagsRepository {
  Future<Result<Map<String, Tag>>> getTags();

  Future<Result<void>> createTag({
    @required String name,
  });

  Future<Result<void>> updateTagName({
    @required String id,
    @required String name,
  });

  Future<Result<void>> updateTagsOrder({
    @required List<Tag> orderedTags,
  });

  Future<Result<void>> deleteTag({
    @required String id,
  });
}
