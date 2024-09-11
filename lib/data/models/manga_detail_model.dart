import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/convert_image_url.dart';
import '../../domain/entities/manga_detail_entity.dart';

part 'manga_detail_model.g.dart';

@JsonSerializable()
class MangaDetailModel extends Equatable {
  final bool? status;
  final DataMangaDetailModel? data;

  const MangaDetailModel({
    required this.status,
    required this.data,
  });

  factory MangaDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MangaDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MangaDetailModelToJson(this);

  MangaDetailEntity toEntity() => MangaDetailEntity(
        status: status,
        data: data?.toEntity(),
      );

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}

@JsonSerializable()
class DataMangaDetailModel extends Equatable {
  final String? title;
  final String? titleIndonesia;
  @JsonKey(fromJson: imageUrlFromJson, toJson: imageUrlToJson)
  final String? imageUrl;
  @JsonKey(fromJson: imageUrlFromJson, toJson: imageUrlToJson)
  final String? thumbnailUrl;
  final String? synopsis;
  final String? type;
  final String? storyConcept;
  final String? author;
  final String? status;
  final num? rating;
  final List<GenreDataMangaDetailModel>? genres;
  final List<ChapterDataMangaDetailModel>? chapters;

  const DataMangaDetailModel({
    required this.title,
    required this.titleIndonesia,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.synopsis,
    required this.type,
    required this.storyConcept,
    required this.author,
    required this.status,
    required this.rating,
    required this.genres,
    required this.chapters,
  });

  factory DataMangaDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DataMangaDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataMangaDetailModelToJson(this);

  DataMangaDetailEntity toEntity() => DataMangaDetailEntity(
        title: title,
        titleIndonesia: titleIndonesia,
        imageUrl: imageUrl,
        thumbnailUrl: thumbnailUrl,
        synopsis: synopsis,
        type: type,
        storyConcept: storyConcept,
        author: author,
        status: status,
        rating: rating,
        genres: genres?.map((item) => item.toEntity()).toList(),
        chapters: chapters?.map((item) => item.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [
        title,
        titleIndonesia,
        imageUrl,
        thumbnailUrl,
        synopsis,
        type,
        storyConcept,
        author,
        status,
        rating,
        genres,
        chapters,
      ];
}

@JsonSerializable()
class GenreDataMangaDetailModel extends Equatable {
  final String? name;
  final String? path;

  const GenreDataMangaDetailModel({
    required this.name,
    required this.path,
  });

  factory GenreDataMangaDetailModel.fromJson(Map<String, dynamic> json) =>
      _$GenreDataMangaDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreDataMangaDetailModelToJson(this);

  GenreDataMangaDetailEntity toEntity() => GenreDataMangaDetailEntity(
        name: name,
        path: path,
      );

  @override
  List<Object?> get props => [
        name,
        path,
      ];
}

@JsonSerializable()
class ChapterDataMangaDetailModel extends Equatable {
  final String? name;
  final num? chapter;
  final String? uploadedDate;
  final String? path;

  const ChapterDataMangaDetailModel({
    required this.name,
    required this.chapter,
    required this.uploadedDate,
    required this.path,
  });

  factory ChapterDataMangaDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterDataMangaDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterDataMangaDetailModelToJson(this);

  ChapterDataMangaDetailEntity toEntity() => ChapterDataMangaDetailEntity(
        name: name,
        chapter: chapter,
        uploadedDate: uploadedDate,
        path: path,
      );

  @override
  List<Object?> get props => [
        name,
        chapter,
        uploadedDate,
        path,
      ];
}
