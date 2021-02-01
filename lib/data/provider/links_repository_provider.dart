import 'package:hooks_riverpod/all.dart';
import '../repository/links_repository.dart';
import '../repository/links_repository_impl.dart';

import 'links_data_source_provider.dart';

final linksRepositoryProvider = Provider<LinksRepository>((ref) =>
    LinksRepositoryImpl(dataSource: ref.read(linksDataSourceProvider)));
