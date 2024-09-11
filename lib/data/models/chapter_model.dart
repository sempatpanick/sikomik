import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/chapter_entity.dart';

part 'chapter_model.g.dart';

@JsonSerializable()
class ChapterModel extends Equatable {
  final bool? status;
  final DataChapterModel? data;

  const ChapterModel({
    required this.status,
    required this.data,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterModelToJson(this);

  ChapterEntity toEntity() => ChapterEntity(
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
class DataChapterModel extends Equatable {
  final String? title;
  final int? chapter;
  final String? uploadedDate;
  final List<String>? images;

  const DataChapterModel({
    required this.title,
    required this.chapter,
    required this.uploadedDate,
    required this.images,
  });

  factory DataChapterModel.fromJson(Map<String, dynamic> json) =>
      _$DataChapterModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataChapterModelToJson(this);

  DataChapterEntity toEntity() => DataChapterEntity(
        title: title,
        chapter: chapter,
        uploadedDate: uploadedDate,
        images: images,
      );

  @override
  List<Object?> get props => [
        title,
        chapter,
        uploadedDate,
        images,
      ];
}
