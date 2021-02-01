import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../remote/tags_data_source.dart';
import '../remote/tags_data_source_impl.dart';
import 'firebase_auth_provider.dart';
import 'firebase_database_provider.dart';

final tagsDataSourceProvider = Provider<TagsDataSource>(
  (ref) => TagsDataSourceImpl(
    ref.read(firebaseAuthProvider),
    ref.read(firebaseDatabaseProvider),
  ),
);
