import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkmark_app/data/model/link.dart';
import 'package:linkmark_app/data/model/result.dart';
import 'package:linkmark_app/data/remote/links_data_source.dart';
import 'package:linkmark_app/data/repository/links_repository.dart';

class LinksRepositoryImpl implements LinksRepository {
  LinksRepositoryImpl({@required LinksDataSource dataSource})
      : _dataSource = dataSource;

  final LinksDataSource _dataSource;

  @override
  Future<Result<Map<String, Link>>> getLinks() async {
    return Result.guardFuture(_dataSource.getLinks);
  }
}
