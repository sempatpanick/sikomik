import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/sikomik_remote_data_source.dart';
import 'data/repositories/sikomik_repository_impl.dart';
import 'domain/repositories/sikomik_repository.dart';
import 'domain/usecases/get_chapter_case.dart';
import 'domain/usecases/get_configuration_case.dart';
import 'domain/usecases/get_latest_manga_case.dart';
import 'domain/usecases/get_manga_detail_case.dart';

final locator = GetIt.instance;

void init() {
  // use case
  locator.registerLazySingleton(() => GetConfigurationCase(repository: locator()));
  locator.registerLazySingleton(() => GetLatestMangaCase(repository: locator()));
  locator.registerLazySingleton(() => GetMangaDetailCase(repository: locator()));
  locator.registerLazySingleton(() => GetChapterCase(repository: locator()));

  // repository
  locator.registerLazySingleton<SiKomikRepository>(
    () => SiKomikRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<SiKomikRemoteDataSource>(
    () => SiKomikRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // helper

  // external
  locator.registerLazySingleton(() => http.Client());
}
