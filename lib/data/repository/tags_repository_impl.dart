import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkmark_app/data/model/result.dart';
import 'package:linkmark_app/data/model/tag.dart';
import 'package:linkmark_app/data/remote/tags_data_source.dart';
import 'package:linkmark_app/data/repository/tags_repository.dart';

class TagsRepositoryImpl extends TagsRepository {
  TagsRepositoryImpl({@required TagsDataSource dataSource})
      : _dataSource = dataSource;

  final TagsDataSource _dataSource;

  @override
  Future<Result<Map<String, Tag>>> getTags() {
    return Result.guardFuture(_dataSource.getTags);
  }
}
