import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/comic_entity.dart';
import '../repositories/sikomik_repository.dart';

class GetLatestComicCase {
  final SiKomikRepository repository;

  GetLatestComicCase({required this.repository});

  Future<Either<Failure, ComicEntity>> execute({
    required int page,
    String? q,
  }) =>
      repository.getLatestComic(page: page, q: q);
}
