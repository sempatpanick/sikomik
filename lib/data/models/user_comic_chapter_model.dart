import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/timestamp_converter.dart';
import '../../domain/entities/user_comic_chapter_entity.dart';
import 'chapter_model.dart';

part 'user_comic_chapter_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserComicChapterModel {
  final String? id;
  @JsonKey(includeIfNull: false)
  final DataChapterModel? chapter;
  @JsonKey(includeIfNull: false)
  @TimestampConverter()
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false)
  @TimestampConverter()
  DateTime? lastUpdated;

  UserComicChapterModel({
    required this.id,
    required this.chapter,
    this.createdAt,
    this.lastUpdated,
  });

  factory UserComicChapterModel.fromJson(Map<String, dynamic> json) =>
      _$UserComicChapterModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserComicChapterModelToJson(this);

  UserComicChapterEntity toEntity() => UserComicChapterEntity(
        id: id,
        chapter: chapter?.toEntity(),
        createdAt: createdAt,
        lastUpdated: lastUpdated,
      );
}
