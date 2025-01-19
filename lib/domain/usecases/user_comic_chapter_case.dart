import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/user_comic_chapter_entity.dart';
import '../repositories/sikomik_repository.dart';

class UserComicChapterCase {
  final SiKomikRepository repository;

  UserComicChapterCase({required this.repository});

  Future<Either<Failure, UserComicChapterEntity>> setUserComicChapterRead({
    required String userId,
    required UserComicChapterEntity data,
  }) =>
      repository.setUserComicChapterRead(
        userId: userId,
        data: data,
      );

  Future<Either<Failure, void>> setBatchUserComicChapterRead({
    required String userId,
    required List<UserComicChapterEntity> data,
  }) =>
      repository.setBatchUserComicChapterRead(
        userId: userId,
        data: data,
      );

  Future<Either<Failure, UserComicChapterEntity>> getUserComicChapterReadById({
    required String userId,
    required String userComicId,
    required String id,
  }) =>
      repository.getUserComicChapterReadById(
        userId: userId,
        userComicId: userComicId,
        id: id,
      );

  Future<Either<Failure, List<UserComicChapterEntity>>>
      getUserComicChaptersRead({
    required String userId,
    required String userComicId,
  }) =>
          repository.getUserComicChaptersRead(
            userId: userId,
            userComicId: userComicId,
          );
}
