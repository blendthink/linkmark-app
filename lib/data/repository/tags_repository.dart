import '../model/result.dart';
import '../model/tag.dart';

abstract class TagsRepository {
  Future<Result<List<Tag>>> getTags();

  Future<Result<void>> createTag({
    required String name,
    required int order,
  });

  Future<Result<void>> updateTagName({
    required String id,
    required String name,
  });

  Future<Result<void>> updateTagsOrder({
    required List<Tag> orderedTags,
  });

  Future<Result<void>> deleteTag({
    required String id,
  });
}
