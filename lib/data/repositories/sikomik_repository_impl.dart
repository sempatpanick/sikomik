import '../../domain/repositories/sikomik_repository.dart';
import '../datasources/sikomik_remote_data_source.dart';

class SiKomikRepositoryImpl implements SiKomikRepository {
  final SiKomikRemoteDataSource remoteDataSource;

  SiKomikRepositoryImpl({
    required this.remoteDataSource,
  });
}
