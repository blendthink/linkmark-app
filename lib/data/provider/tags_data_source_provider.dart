import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkmark_app/data/provider/firebase_auth_provider.dart';
import 'package:linkmark_app/data/provider/firebase_database_provider.dart';
import 'package:linkmark_app/data/remote/tags_data_source.dart';
import 'package:linkmark_app/data/remote/tags_data_source_impl.dart';

final tagsDataSourceProvider = Provider<TagsDataSource>(
  (ref) => TagsDataSourceImpl(
    ref.read(firebaseAuthProvider),
    ref.read(firebaseDatabaseProvider),
  ),
);
