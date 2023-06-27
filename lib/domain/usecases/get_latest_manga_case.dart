import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/manga_entity.dart';
import '../repositories/sikomik_repository.dart';

class GetLatestMangaCase {
  final SiKomikRepository repository;

  GetLatestMangaCase({required this.repository});

  Future<Either<Failure, MangaEntity>> execute({
    required int page,
    String? q,
  }) =>
      repository.getLatestManga(page: page, q: q);
}
