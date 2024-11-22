import 'package:equatable/equatable.dart';

import '../../data/models/user_comic_model.dart';
import 'chapter_entity.dart';
import 'comic_detail_entity.dart';

class UserComicEntity extends Equatable {
  final String? id;
  final ComicDetailEntity? comic;
  final List<DataChapterEntity>? readChapters;
  final DataChapterEntity? lastReadChapter;
  final bool? isFavorite;
  final DateTime? createdAt;
  final DateTime? lastUpdated;

  const UserComicEntity({
    required this.id,
    required this.comic,
    required this.readChapters,
    required this.lastReadChapter,
    required this.isFavorite,
    this.createdAt,
    this.lastUpdated,
  });

  UserComicModel toModel() => UserComicModel(
        id: id,
        comic: comic?.toModel(),
        readChapters: readChapters?.map((item) => item.toModel()).toList(),
        lastReadChapter: lastReadChapter?.toModel(),
        isFavorite: isFavorite,
        createdAt: createdAt,
        lastUpdated: lastUpdated,
      );

  @override
  List<Object?> get props => [
        id,
        comic,
        readChapters,
        lastReadChapter,
        isFavorite,
        createdAt,
        lastUpdated,
      ];
}
