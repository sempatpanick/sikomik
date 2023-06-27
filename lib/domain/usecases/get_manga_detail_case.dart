import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/manga_detail_entity.dart';
import '../repositories/sikomik_repository.dart';

class GetMangaDetailCase {
  final SiKomikRepository repository;

  GetMangaDetailCase({required this.repository});

  Future<Either<Failure, MangaDetailEntity>> execute({
    required String path,
  }) =>
      repository.getMangaDetail(path: path);
}
