import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/timestamp_converter.dart';
import '../../domain/entities/user_comic_entity.dart';
import 'chapter_model.dart';
import 'comic_detail_model.dart';

part 'user_comic_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserComicModel {
  final String? id;
  @JsonKey(includeIfNull: false)
  final DataComicDetailModel? comic;
  @JsonKey(includeIfNull: false)
  final List<DataChapterModel>? readChapters;
  @JsonKey(includeIfNull: false)
  final DataChapterModel? lastReadChapter;
  @JsonKey(includeIfNull: false)
  final bool? isFavorite;
  @JsonKey(includeIfNull: false)
  @TimestampConverter()
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false)
  @TimestampConverter()
  DateTime? lastUpdated;

  UserComicModel({
    required this.id,
    required this.comic,
    required this.readChapters,
    required this.lastReadChapter,
    required this.isFavorite,
    this.createdAt,
    this.lastUpdated,
  });

  factory UserComicModel.fromJson(Map<String, dynamic> json) =>
      _$UserComicModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserComicModelToJson(this);

  UserComicEntity toEntity() => UserComicEntity(
        id: id,
        comic: comic?.toEntity(),
        readChapters: readChapters?.map((item) => item.toEntity()).toList(),
        lastReadChapter: lastReadChapter?.toEntity(),
        isFavorite: isFavorite,
        createdAt: createdAt,
        lastUpdated: lastUpdated,
      );
}
