import '../model/result.dart';
import '../model/tag.dart';
import '../remote/tags_data_source.dart';
import 'tags_repository.dart';

class TagsRepositoryImpl extends TagsRepository {
  TagsRepositoryImpl({required TagsDataSource dataSource})
      : _dataSource = dataSource;

  final TagsDataSource _dataSource;

  @override
  Future<Result<List<Tag>>> getTags() {
    return Result.guardFuture(_dataSource.getTags);
  }

  @override
  Future<Result<void>> createTag({
    required String name,
    required int order,
  }) {
    return Result.guardFuture(
      () => _dataSource.createTag(
        name: name,
        order: order,
      ),
    );
  }

  @override
  Future<Result<void>> updateTagName({
    required String id,
    required String name,
  }) {
    return Result.guardFuture(
      () => _dataSource.updateTagName(
        id: id,
        name: name,
      ),
    );
  }

  @override
  Future<Result<void>> updateTagsOrder({
    required List<Tag> orderedTags,
  }) {
    return Result.guardFuture(
        () => _dataSource.updateTagsOrder(orderedTags: orderedTags));
  }

  @override
  Future<Result<void>> deleteTag({
    required String id,
  }) {
    return Result.guardFuture(
      () => _dataSource.deleteTag(
        id: id,
      ),
    );
  }
}
