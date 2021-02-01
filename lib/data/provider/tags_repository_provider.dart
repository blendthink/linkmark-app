import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository/tags_repository.dart';
import '../repository/tags_repository_impl.dart';
import 'tags_data_source_provider.dart';

final tagsRepositoryProvider = Provider<TagsRepository>(
    (ref) => TagsRepositoryImpl(dataSource: ref.read(tagsDataSourceProvider)));
