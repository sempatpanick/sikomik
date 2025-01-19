import 'package:equatable/equatable.dart';

import '../../data/models/user_comic_model.dart';
import 'chapter_entity.dart';
import 'comic_detail_entity.dart';

class UserComicEntity extends Equatable {
  final String? id;
  final DataComicDetailEntity? comic;
  final DataChapterEntity? lastReadChapter;
  final bool? isFavorite;
  final DateTime? createdAt;
  final DateTime? lastUpdated;

  const UserComicEntity({
    required this.id,
    this.comic,
    this.lastReadChapter,
    this.isFavorite,
    this.createdAt,
    this.lastUpdated,
  });

  UserComicModel toModel() => UserComicModel(
        id: id,
        comic: comic?.toModel(),
        lastReadChapter: lastReadChapter?.toModel(),
        isFavorite: isFavorite,
        createdAt: createdAt,
        lastUpdated: lastUpdated,
      );

  @override
  List<Object?> get props => [
        id,
        comic,
        lastReadChapter,
        isFavorite,
        createdAt,
        lastUpdated,
      ];
}
