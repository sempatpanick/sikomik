import 'package:equatable/equatable.dart';

import '../../data/models/user_comic_chapter_model.dart';
import 'chapter_entity.dart';

class UserComicChapterEntity extends Equatable {
  final String? id;
  final DataChapterEntity? chapter;
  final DateTime? createdAt;
  final DateTime? lastUpdated;

  const UserComicChapterEntity({
    required this.id,
    this.chapter,
    this.createdAt,
    this.lastUpdated,
  });

  UserComicChapterModel toModel() => UserComicChapterModel(
        id: id,
        chapter: chapter?.toModel(),
        createdAt: createdAt,
        lastUpdated: lastUpdated,
      );

  @override
  List<Object?> get props => [
        id,
        chapter,
        createdAt,
        lastUpdated,
      ];
}
