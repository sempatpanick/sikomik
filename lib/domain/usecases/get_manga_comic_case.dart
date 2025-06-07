import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/comic_entity.dart';
import '../repositories/sikomik_repository.dart';

class GetMangaComicCase {
  final SiKomikRepository repository;

  GetMangaComicCase({required this.repository});

  Future<Either<Failure, ComicEntity>> execute({
    required int page,
  }) =>
      repository.getMangaComic(page: page);
}
