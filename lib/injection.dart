import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/sikomik_remote_data_source.dart';
import 'data/repositories/sikomik_repository_impl.dart';
import 'domain/repositories/sikomik_repository.dart';

final locator = GetIt.instance;

void init() {
  // use case

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
