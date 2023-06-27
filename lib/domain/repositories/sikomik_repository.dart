import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/chapter_entity.dart';
import '../entities/manga_detail_entity.dart';
import '../entities/manga_entity.dart';

abstract class SiKomikRepository {
  Future<Either<Failure, MangaEntity>> getLatestManga({
    required int page,
    String? q,
  });
  Future<Either<Failure, MangaDetailEntity>> getMangaDetail({
    required String path,
  });
  Future<Either<Failure, ChapterEntity>> getChapter({
    required String path,
  });
}
