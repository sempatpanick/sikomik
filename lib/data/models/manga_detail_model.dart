import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/manga_detail_entity.dart';

part 'manga_detail_model.g.dart';

@JsonSerializable()
class MangaDetailModel extends Equatable {
  final bool status;
  final DataMangaDetailModel data;

  const MangaDetailModel({
    required this.status,
    required this.data,
  });

  factory MangaDetailModel.fromJson(Map<String, dynamic> json) => _$MangaDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MangaDetailModelToJson(this);

  MangaDetailEntity toEntity() => MangaDetailEntity(
        status: status,
        data: data.toEntity(),
      );

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}

@JsonSerializable()
class DataMangaDetailModel extends Equatable {
  final String title;
  final String? description;
  final num rating;
  final List<List<String>> informations;
  final List<GenreDataMangaDetailModel> genres;
  final List<ChapterDataMangaDetailModel> chapters;
  @JsonKey(name: 'image_path')
  final String imagePath;

  const DataMangaDetailModel({
    required this.title,
    this.description,
    required this.rating,
    required this.informations,
    required this.genres,
    required this.chapters,
    required this.imagePath,
  });

  factory DataMangaDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DataMangaDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataMangaDetailModelToJson(this);

  DataMangaDetailEntity toEntity() => DataMangaDetailEntity(
        title: title,
        description: description,
        rating: rating,
        informations: informations,
        genres: genres.map((item) => item.toEntity()).toList(),
        chapters: chapters.map((item) => item.toEntity()).toList(),
        imagePath: imagePath,
      );

  @override
  List<Object?> get props => [
        title,
        description,
        rating,
        informations,
        genres,
        chapters,
        imagePath,
      ];
}

@JsonSerializable()
class GenreDataMangaDetailModel extends Equatable {
  final String name;
  final String path;

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
  final num chapter;
  @JsonKey(name: 'upload_at')
  final String uploadAt;
  final String path;

  const ChapterDataMangaDetailModel({
    required this.chapter,
    required this.uploadAt,
    required this.path,
  });

  factory ChapterDataMangaDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterDataMangaDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterDataMangaDetailModelToJson(this);

  ChapterDataMangaDetailEntity toEntity() => ChapterDataMangaDetailEntity(
        chapter: chapter,
        uploadAt: uploadAt,
        path: path,
      );

  @override
  List<Object?> get props => [
        chapter,
        uploadAt,
        path,
      ];
}
