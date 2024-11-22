import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/timestamp_converter.dart';
import '../../domain/entities/user_comic_entity.dart';
import 'chapter_model.dart';
import 'comic_detail_model.dart';

part 'user_comic_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserComicModel extends Equatable {
  final String? id;
  final ComicDetailModel? comic;
  final List<DataChapterModel>? readChapters;
  final DataChapterModel? lastReadChapter;
  final bool? isFavorite;
  @JsonKey(includeIfNull: false)
  @TimestampConverter()
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false)
  @TimestampConverter()
  final DateTime? lastUpdated;

  const UserComicModel({
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
