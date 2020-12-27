import 'package:hooks_riverpod/all.dart';
import 'package:linkmark_app/data/provider/links_data_source_provider.dart';
import 'package:linkmark_app/data/repository/links_repository.dart';
import 'package:linkmark_app/data/repository/links_repository_impl.dart';

final linksRepositoryProvider = Provider<LinksRepository>((ref) =>
    LinksRepositoryImpl(dataSource: ref.read(linksDataSourceProvider)));
