import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/convert_image_url.dart';
import '../../domain/entities/comic_detail_entity.dart';

part 'comic_detail_model.g.dart';

@JsonSerializable()
class ComicDetailModel extends Equatable {
  final bool? status;
  final DataComicDetailModel? data;

  const ComicDetailModel({
    required this.status,
    required this.data,
  });

  factory ComicDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ComicDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ComicDetailModelToJson(this);

  ComicDetailEntity toEntity() => ComicDetailEntity(
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
class DataComicDetailModel extends Equatable {
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
  final List<GenreDataComicDetailModel>? genres;
  final List<ChapterDataComicDetailModel>? chapters;

  const DataComicDetailModel({
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

  factory DataComicDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DataComicDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataComicDetailModelToJson(this);

  DataComicDetailEntity toEntity() => DataComicDetailEntity(
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
class GenreDataComicDetailModel extends Equatable {
  final String? name;
  final String? path;

  const GenreDataComicDetailModel({
    required this.name,
    required this.path,
  });

  factory GenreDataComicDetailModel.fromJson(Map<String, dynamic> json) =>
      _$GenreDataComicDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreDataComicDetailModelToJson(this);

  GenreDataComicDetailEntity toEntity() => GenreDataComicDetailEntity(
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
class ChapterDataComicDetailModel extends Equatable {
  final String? name;
  final num? chapter;
  final String? uploadedDate;
  final String? path;

  const ChapterDataComicDetailModel({
    required this.name,
    required this.chapter,
    required this.uploadedDate,
    required this.path,
  });

  factory ChapterDataComicDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterDataComicDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterDataComicDetailModelToJson(this);

  ChapterDataComicDetailEntity toEntity() => ChapterDataComicDetailEntity(
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
