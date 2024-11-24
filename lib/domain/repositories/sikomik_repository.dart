import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common/enums.dart';
import '../../common/failure.dart';
import '../entities/chapter_entity.dart';
import '../entities/comic_detail_entity.dart';
import '../entities/comic_entity.dart';
import '../entities/configuration_entity.dart';
import '../entities/user_comic_entity.dart';
import '../entities/user_entity.dart';

abstract class SiKomikRepository {
  Future<Either<Failure, ConfigurationEntity>> getConfiguration();
  Future<Either<Failure, ComicEntity>> getLatestComic({
    required int page,
    String? q,
  });
  Future<Either<Failure, ComicDetailEntity>> getComicDetail({
    required String path,
  });
  Future<Either<Failure, ChapterEntity>> getChapter({
    required String path,
  });
  Future<Either<Failure, ComicEntity>> searchComic({
    required String query,
  });

  Future<Either<Failure, UserEntity>> setUser({
    required UserEntity user,
  });
  Future<Either<Failure, UserEntity>> getUserDetail({
    required String userId,
  });
  Future<Either<Failure, UserComicEntity>> setUserComic({
    required String userId,
    required UserComicEntity userComic,
  });
  Future<Either<Failure, UserComicEntity>> getUserComicById({
    required String userId,
    required String id,
  });
  Future<Either<Failure, List<UserComicEntity>>> getFavorites({
    required String userId,
  });
  Future<Either<Failure, UserComicEntity>> getFavoriteById({
    required String userId,
    required String id,
  });

  Future<Either<Failure, UserCredential>> login({
    String? email,
    String? password,
    required LoginType type,
  });
  Future<Either<Failure, UserCredential>> register({
    required String email,
    required String password,
  });
  Future<Either<Failure, User?>> getUser();
  Future<Either<Failure, Stream<User?>>> streamUser();
  Future<Either<Failure, void>> logout();
}
