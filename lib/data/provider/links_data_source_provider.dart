import 'package:hooks_riverpod/all.dart';
import 'package:linkmark_app/data/provider/firebase_auth_provider.dart';
import 'package:linkmark_app/data/provider/firebase_database_provider.dart';
import 'package:linkmark_app/data/remote/links_data_source.dart';
import 'package:linkmark_app/data/remote/links_data_source_impl.dart';

final linksDataSourceProvider = Provider<LinksDataSource>(
  (ref) => LinksDataSourceImpl(
    ref.read(firebaseAuthProvider),
    ref.read(firebaseDatabaseProvider),
  ),
);
