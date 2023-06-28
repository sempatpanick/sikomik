import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/manga_entity.dart';

part 'manga_model.g.dart';

@JsonSerializable()
class MangaModel extends Equatable {
  final bool status;
  final int page;
  @JsonKey(name: 'max_page')
  final int maxPage;
  final List<DataMangaModel> data;

  const MangaModel({
    required this.status,
    required this.page,
    required this.maxPage,
    required this.data,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) => _$MangaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MangaModelToJson(this);

  MangaEntity toEntity() => MangaEntity(
        status: status,
        page: page,
        maxPage: maxPage,
        data: data.map((item) => item.toEntity()).toList(),
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
  final String title;
  final num chapter;
  final num rating;
  @JsonKey(name: 'image_path')
  final String imagePath;
  final String path;

  const DataMangaModel({
    required this.title,
    required this.chapter,
    required this.rating,
    required this.imagePath,
    required this.path,
  });

  factory DataMangaModel.fromJson(Map<String, dynamic> json) => _$DataMangaModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataMangaModelToJson(this);

  DataMangaEntity toEntity() => DataMangaEntity(
        title: title,
        chapter: chapter,
        rating: rating,
        imagePath: imagePath,
        path: path,
      );

  @override
  List<Object?> get props => [
        title,
        chapter,
        rating,
        imagePath,
        path,
      ];
}
