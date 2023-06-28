import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/configuration_entity.dart';
import '../repositories/sikomik_repository.dart';

class GetConfigurationCase {
  final SiKomikRepository repository;

  GetConfigurationCase({required this.repository});

  Future<Either<Failure, ConfigurationEntity>> execute() => repository.getConfiguration();
}
