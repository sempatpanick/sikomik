import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/convert_image_url.dart';
import '../../domain/entities/manga_entity.dart';

part 'manga_model.g.dart';

@JsonSerializable()
class MangaModel extends Equatable {
  final bool? status;
  final int? page;
  @JsonKey(name: 'max_page')
  final int? maxPage;
  final List<DataMangaModel>? data;

  const MangaModel({
    required this.status,
    required this.page,
    required this.maxPage,
    required this.data,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) =>
      _$MangaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MangaModelToJson(this);

  MangaEntity toEntity() => MangaEntity(
        status: status,
        page: page,
        maxPage: maxPage,
        data: data?.map((item) => item.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [
        status,
        page,
        maxPage,
        data,
      ];
}

@JsonSerializable()
class DataMangaModel extends Equatable {
  final String? title;
  @JsonKey(fromJson: imageUrlFromJson, toJson: imageUrlToJson)
  final String? imageUrl;
  final num? chapter;
  final num? rating;
  final String? status;
  final String? lastUpdated;
  final String? path;

  const DataMangaModel({
    required this.title,
    required this.imageUrl,
    required this.chapter,
    required this.rating,
    required this.status,
    required this.lastUpdated,
    required this.path,
  });

  factory DataMangaModel.fromJson(Map<String, dynamic> json) =>
      _$DataMangaModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataMangaModelToJson(this);

  DataMangaEntity toEntity() => DataMangaEntity(
        title: title,
        imageUrl: imageUrl,
        chapter: chapter,
        rating: rating,
        status: status,
        lastUpdated: lastUpdated,
        path: path,
      );

  @override
  List<Object?> get props => [
        title,
        imageUrl,
        chapter,
        rating,
        status,
        lastUpdated,
        path,
      ];
}
