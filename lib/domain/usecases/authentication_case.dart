import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common/enums.dart';
import '../../common/failure.dart';
import '../repositories/sikomik_repository.dart';

class AuthenticationCase {
  final SiKomikRepository repository;

  AuthenticationCase({required this.repository});

  Future<Either<Failure, UserCredential>> login({
    String? email,
    String? password,
    required LoginType type,
  }) =>
      repository.login(
        email: email,
        password: password,
        type: type,
      );

  Future<Either<Failure, UserCredential>> register({
    required String email,
    required String password,
  }) =>
      repository.register(
        email: email,
        password: password,
      );

  Future<Either<Failure, User?>> getUser() => repository.getUser();

  Future<Either<Failure, Stream<User?>>> streamUser() =>
      repository.streamUser();

  Future<Either<Failure, void>> logout() => repository.logout();
}
