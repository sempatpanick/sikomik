import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/chapter_entity.dart';
import '../entities/comic_detail_entity.dart';
import '../entities/comic_entity.dart';
import '../entities/configuration_entity.dart';

abstract class SiKomikRepository {
  Future<Either<Failure, ConfigurationEntity>> getConfiguration();
  Future<Either<Failure, ComicEntity>> getLatestComic({
    required int page,
    String? q,
  });
  Future<Either<Failure, ComicDetailEntity>> getComicDetail({
    required String path,
  });
  Future<Either<Failure, ChapterEntity>> getChapter({
    required String path,
  });
}
