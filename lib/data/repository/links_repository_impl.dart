import '../model/link.dart';
import '../model/result.dart';
import '../remote/links_data_source.dart';
import 'links_repository.dart';

class LinksRepositoryImpl implements LinksRepository {
  LinksRepositoryImpl({required LinksDataSource dataSource})
      : _dataSource = dataSource;

  final LinksDataSource _dataSource;

  @override
  Future<Result<List<Link>>> getLinks() async {
    return Result.guardFuture(_dataSource.getLinks);
  }

  @override
  Future<Result<void>> createLink({required String url}) {
    return Result.guardFuture(() => _dataSource.createLink(url: url));
  }

  @override
  Future<Result<void>> deleteLink({required String id}) {
    return Result.guardFuture(() => _dataSource.deleteLink(id: id));
  }
}
