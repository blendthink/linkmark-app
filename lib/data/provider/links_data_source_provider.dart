import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../remote/links_data_source.dart';
import '../remote/links_data_source_impl.dart';

import 'firebase_auth_provider.dart';
import 'firebase_database_provider.dart';

final linksDataSourceProvider = Provider<LinksDataSource>(
  (ref) => LinksDataSourceImpl(
    ref.read(firebaseAuthProvider),
    ref.read(firebaseDatabaseProvider),
  ),
);
