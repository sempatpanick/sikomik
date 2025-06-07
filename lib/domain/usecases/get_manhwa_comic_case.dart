import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/comic_entity.dart';
import '../repositories/sikomik_repository.dart';

class GetManhwaComicCase {
  final SiKomikRepository repository;

  GetManhwaComicCase({required this.repository});

  Future<Either<Failure, ComicEntity>> execute({
    required int page,
  }) =>
      repository.getManhwaComic(page: page);
}
