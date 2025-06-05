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
import '../../domain/entities/user_comic_chapter_entity.dart';
import '../../domain/entities/user_comic_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/sikomik_repository.dart';
import '../datasources/sikomik_firebase_auth_data_source.dart';
import '../datasources/sikomik_firebase_firestore_data_source.dart';
import '../datasources/sikomik_remote_data_source.dart';

class SiKomikRepositoryImpl implements SiKomikRepository {
  final SiKomikRemoteDataSource remoteDataSource;
  final SiKomikFirebaseAuthDataSource firebaseAuthDataSource;
  final SiKomikFirebaseFirestoreDataSource firebaseFirestoreDataSource;

  SiKomikRepositoryImpl({
    required this.remoteDataSource,
    required this.firebaseAuthDataSource,
    required this.firebaseFirestoreDataSource,
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
  Future<Either<Failure, ComicEntity>> searchComic({
    required String query,
  }) async {
    try {
      final result = await remoteDataSource.searchComic(query: query);

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
  Future<Either<Failure, UserEntity>> setUser({
    required UserEntity user,
  }) async {
    try {
      final result = await firebaseFirestoreDataSource.setUser(
        user: user.toModel(),
      );

      if (result == null) {
        return Left(ResponseFailure("Failed to add/update user"));
      }

      return Right(result.toEntity());
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
  Future<Either<Failure, UserEntity>> getUserDetail({
    required String userId,
  }) async {
    try {
      final result = await firebaseFirestoreDataSource.getUser(userId: userId);

      if (result == null) {
        return Left(ResponseFailure("Failed to add/update user"));
      }

      return Right(result.toEntity());
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
  Future<Either<Failure, UserComicEntity>> setUserComic({
    required String userId,
    required UserComicEntity data,
  }) async {
    try {
      final result = await firebaseFirestoreDataSource.setUserComic(
        userId: userId,
        data: data.toModel(),
      );

      if (result == null) {
        return Left(ResponseFailure("Failed to add/update comic"));
      }

      return Right(result.toEntity());
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
  Future<Either<Failure, UserComicEntity>> getUserComicById({
    required String userId,
    required String id,
  }) async {
    try {
      final result = await firebaseFirestoreDataSource.getUserComicById(
        userId: userId,
        id: id,
      );

      if (result == null) {
        return Left(ResponseFailure("Comic not found"));
      }

      return Right(result.toEntity());
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
  Future<Either<Failure, List<UserComicEntity>>> getFavorites({
    required String userId,
  }) async {
    try {
      final result = await firebaseFirestoreDataSource.getFavorites(
        userId: userId,
      );

      return Right(result.map((item) => item.toEntity()).toList());
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
  Future<Either<Failure, UserComicEntity>> getFavoriteById({
    required String userId,
    required String id,
  }) async {
    try {
      final result = await firebaseFirestoreDataSource.getFavoriteById(
        userId: userId,
        id: id,
      );

      if (result == null) {
        return Left(ResponseFailure("There's no favorite"));
      }

      return Right(result.toEntity());
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
  Future<Either<Failure, UserComicChapterEntity>> setUserComicChapterRead({
    required String userId,
    required UserComicChapterEntity data,
  }) async {
    try {
      final result = await firebaseFirestoreDataSource.setUserComicChapterRead(
        userId: userId,
        data: data.toModel(),
      );

      if (result == null) {
        return Left(ResponseFailure("Failed to set chapter as chapter read"));
      }

      return Right(result.toEntity());
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
  Future<Either<Failure, void>> setBatchUserComicChapterRead({
    required String userId,
    required List<UserComicChapterEntity> data,
  }) async {
    try {
      final result =
          await firebaseFirestoreDataSource.setBatchUserComicChapterRead(
        userId: userId,
        data: data.map((item) => item.toModel()).toList(),
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
  Future<Either<Failure, UserComicChapterEntity>> getUserComicChapterReadById({
    required String userId,
    required String userComicId,
    required String id,
  }) async {
    try {
      final result =
          await firebaseFirestoreDataSource.getUserComicChapterReadById(
        userId: userId,
        userComicId: userComicId,
        id: id,
      );

      if (result == null) {
        return Left(ResponseFailure("Chapter not found"));
      }

      return Right(result.toEntity());
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
  Future<Either<Failure, List<UserComicChapterEntity>>>
      getUserComicChaptersRead({
    required String userId,
    required String userComicId,
  }) async {
    try {
      final result = await firebaseFirestoreDataSource.getUserComicChaptersRead(
        userId: userId,
        userComicId: userComicId,
      );

      return Right(result.map((item) => item.toEntity()).toList());
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
