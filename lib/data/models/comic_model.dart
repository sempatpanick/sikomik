import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/convert_image_url.dart';
import '../../domain/entities/comic_entity.dart';

part 'comic_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ComicModel extends Equatable {
  final bool? status;
  final int? page;
  @JsonKey(name: 'max_page')
  final int? maxPage;
  final List<DataComicModel>? data;

  const ComicModel({
    required this.status,
    required this.page,
    required this.maxPage,
    required this.data,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) =>
      _$ComicModelFromJson(json);

  Map<String, dynamic> toJson() => _$ComicModelToJson(this);

  ComicEntity toEntity() => ComicEntity(
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

@JsonSerializable(explicitToJson: true)
class DataComicModel extends Equatable {
  final String? title;
  @JsonKey(fromJson: imageUrlFromJson, toJson: imageUrlToJson)
  final String? imageUrl;
  final num? chapter;
  final num? rating;
  final String? status;
  final String? lastUpdated;
  final String? path;

  const DataComicModel({
    required this.title,
    required this.imageUrl,
    required this.chapter,
    required this.rating,
    required this.status,
    required this.lastUpdated,
    required this.path,
  });

  factory DataComicModel.fromJson(Map<String, dynamic> json) =>
      _$DataComicModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataComicModelToJson(this);

  DataComicEntity toEntity() => DataComicEntity(
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
