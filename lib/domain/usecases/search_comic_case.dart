import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/comic_entity.dart';
import '../repositories/sikomik_repository.dart';

class SearchComicCase {
  final SiKomikRepository repository;

  SearchComicCase({required this.repository});

  Future<Either<Failure, ComicEntity>> execute({
    required String query,
  }) =>
      repository.searchComic(query: query);
}
