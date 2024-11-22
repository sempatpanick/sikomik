import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/user_comic_entity.dart';
import '../repositories/sikomik_repository.dart';

class UserComicCase {
  final SiKomikRepository repository;

  UserComicCase({required this.repository});

  Future<Either<Failure, UserComicEntity>> setUserComic({
    required String userId,
    required UserComicEntity userComic,
  }) =>
      repository.setUserComic(userId: userId, userComic: userComic);

  Future<Either<Failure, UserComicEntity>> getUserComicById({
    required String userId,
    required String id,
  }) =>
      repository.getUserComicById(userId: userId, id: id);

  Future<Either<Failure, List<UserComicEntity>>> getFavorites({
    required String userId,
  }) =>
      repository.getFavorites(userId: userId);

  Future<Either<Failure, UserComicEntity>> getFavoriteById({
    required String userId,
    required String id,
  }) =>
      repository.getFavoriteById(userId: userId, id: id);
}
