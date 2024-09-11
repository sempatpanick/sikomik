import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/comic_detail_entity.dart';
import '../repositories/sikomik_repository.dart';

class GetComicDetailCase {
  final SiKomikRepository repository;

  GetComicDetailCase({required this.repository});

  Future<Either<Failure, ComicDetailEntity>> execute({
    required String path,
  }) =>
      repository.getComicDetail(path: path);
}
