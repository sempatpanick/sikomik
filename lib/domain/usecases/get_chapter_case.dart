import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/chapter_entity.dart';
import '../repositories/sikomik_repository.dart';

class GetChapterCase {
  final SiKomikRepository repository;

  GetChapterCase({required this.repository});

  Future<Either<Failure, ChapterEntity>> execute({
    required String path,
  }) =>
      repository.getChapter(path: path);
}
