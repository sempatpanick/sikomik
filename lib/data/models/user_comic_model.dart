import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/convert_image_url.dart';
import '../../common/utils/timestamp_converter.dart';
import '../../domain/entities/comic_entity.dart';
import 'chapter_model.dart';
import 'comic_detail_model.dart';

part 'comic_model.g.dart';

@JsonSerializable()
class UserComicModel extends Equatable {
  final ComicDetailModel? comic;
  final List<DataChapterModel>? readChapters;
  final DataChapterModel? lastReadChapter;
  final bool? isFavorite;
  @TimestampConverter()
  final DateTime? createdAt;
  @TimestampConverter()
  final DateTime? lastUpdated;

  const UserComicModel({
    required this.comic,
    required this.readChapters,
    required this.lastReadChapter,
    required this.isFavorite,
    required this.createdAt,
    required this.lastUpdated,
  });

  factory UserComicModel.fromJson(Map<String, dynamic> json) =>
      _$UserComicModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserComicModelToJson(this);

  UserComicEntity toEntity() => UserComicEntity(
        comic: comic,
        readChapters: readChapters,
        lastReadChapter: lastReadChapter,
        isFavorite: isFavorite,
        createdAt: createdAt,
        lastUpdated: lastUpdated,
      );

  @override
  List<Object?> get props => [
        comic,
        readChapters,
        lastReadChapter,
        isFavorite,
        createdAt,
        lastUpdated,
      ];
}
