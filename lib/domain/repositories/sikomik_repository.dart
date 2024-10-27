import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common/enums.dart';
import '../../common/failure.dart';
import '../entities/chapter_entity.dart';
import '../entities/comic_detail_entity.dart';
import '../entities/comic_entity.dart';
import '../entities/configuration_entity.dart';

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
