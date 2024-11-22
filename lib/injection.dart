import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/sikomik_firebase_auth_data_source.dart';
import 'data/datasources/sikomik_firebase_firestore_data_source.dart';
import 'data/datasources/sikomik_remote_data_source.dart';
import 'data/repositories/sikomik_repository_impl.dart';
import 'domain/repositories/sikomik_repository.dart';
import 'domain/usecases/authentication_case.dart';
import 'domain/usecases/get_chapter_case.dart';
import 'domain/usecases/get_comic_detail_case.dart';
import 'domain/usecases/get_configuration_case.dart';
import 'domain/usecases/get_latest_comic_case.dart';
import 'domain/usecases/user_comic_case.dart';
import 'domain/usecases/user_detail_case.dart';

final locator = GetIt.instance;

void init() {
  // use case
  locator.registerLazySingleton(
    () => GetConfigurationCase(repository: locator()),
  );
  locator.registerLazySingleton(
    () => GetLatestComicCase(repository: locator()),
  );
  locator.registerLazySingleton(
    () => GetComicDetailCase(repository: locator()),
  );
  locator.registerLazySingleton(
    () => GetChapterCase(repository: locator()),
  );
  locator.registerLazySingleton(
    () => AuthenticationCase(repository: locator()),
  );
  locator.registerLazySingleton(
    () => UserDetailCase(repository: locator()),
  );
  locator.registerLazySingleton(
    () => UserComicCase(repository: locator()),
  );

  // repository
  locator.registerLazySingleton<SiKomikRepository>(
    () => SiKomikRepositoryImpl(
      remoteDataSource: locator(),
      firebaseAuthDataSource: locator(),
      firebaseFirestoreDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<SiKomikRemoteDataSource>(
    () => SiKomikRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<SiKomikFirebaseAuthDataSource>(
    () => SiKomikFirebaseAuthDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<SiKomikFirebaseFirestoreDataSource>(
    () => SiKomikFirebaseFirestoreDataSourceImpl(
      client: locator(),
    ),
  );

  // helper

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
}
