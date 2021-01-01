import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/data/provider/tags_data_source_provider.dart';
import 'package:linkmark_app/data/repository/tags_repository.dart';
import 'package:linkmark_app/data/repository/tags_repository_impl.dart';

final tagsRepositoryProvider = Provider<TagsRepository>(
    (ref) => TagsRepositoryImpl(dataSource: ref.read(tagsDataSourceProvider)));
