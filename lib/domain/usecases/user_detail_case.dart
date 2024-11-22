import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/sikomik_repository.dart';

class UserDetailCase {
  final SiKomikRepository repository;

  UserDetailCase({required this.repository});

  Future<Either<Failure, UserEntity>> setUser({
    required UserEntity user,
  }) =>
      repository.setUser(user: user);

  Future<Either<Failure, UserEntity>> getUserDetail({
    required String userId,
  }) =>
      repository.getUserDetail(userId: userId);
}
