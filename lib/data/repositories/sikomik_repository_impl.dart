import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common/enums.dart';
import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/entities/chapter_entity.dart';
import '../../domain/entities/comic_detail_entity.dart';
import '../../domain/entities/comic_entity.dart';
import '../../domain/entities/configuration_entity.dart';
import '../../domain/repositories/sikomik_repository.dart';
import '../datasources/sikomik_firebase_auth_data_source.dart';
import '../datasources/sikomik_remote_data_source.dart';

class SiKomikRepositoryImpl implements SiKomikRepository {
  final SiKomikRemoteDataSource remoteDataSource;
  final SiKomikFirebaseAuthDataSource firebaseAuthDataSource;

  SiKomikRepositoryImpl({
    required this.remoteDataSource,
    required this.firebaseAuthDataSource,
  });

  @override
  Future<Either<Failure, ConfigurationEntity>> getConfiguration() async {
    try {
      final result = await remoteDataSource.getConfiguration();

      return Right(result.toEntity());
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ComicEntity>> getLatestComic({
    required int page,
    String? q,
  }) async {
    try {
      final result = await remoteDataSource.getLatestComic(page: page, q: q);

      return Right(result.toEntity());
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ComicDetailEntity>> getComicDetail({
    required String path,
  }) async {
    try {
      final result = await remoteDataSource.getComicDetail(path: path);

      return Right(result.toEntity());
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChapterEntity>> getChapter({
    required String path,
  }) async {
    try {
      final result = await remoteDataSource.getChapter(path: path);

      return Right(result.toEntity());
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> login({
    String? email,
    String? password,
    required LoginType type,
  }) async {
    try {
      final result = await firebaseAuthDataSource.login(
        email: email,
        password: password,
        type: type,
      );

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ResponseFailure(e.message ?? "Failed to proceed"));
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> register({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuthDataSource.register(
        email: email,
        password: password,
      );

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ResponseFailure(e.message ?? "Failed to proceed"));
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getUser() async {
    try {
      final result = await firebaseAuthDataSource.getUser();

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ResponseFailure(e.message ?? "Failed to proceed"));
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<User?>>> streamUser() async {
    try {
      final result = await firebaseAuthDataSource.streamUser();

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ResponseFailure(e.message ?? "Failed to proceed"));
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await firebaseAuthDataSource.logout();

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ResponseFailure(e.message ?? "Failed to proceed"));
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
