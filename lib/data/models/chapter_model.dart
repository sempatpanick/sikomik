import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/chapter_entity.dart';

part 'chapter_model.g.dart';

@JsonSerializable()
class ChapterModel extends Equatable {
  final bool status;
  final DataChapterModel data;

  const ChapterModel({
    required this.status,
    required this.data,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) => _$ChapterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterModelToJson(this);

  ChapterEntity toEntity() => ChapterEntity(
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
class DataChapterModel extends Equatable {
  final List<String> images;
  @JsonKey(name: 'previous_chapter_path')
  final String? previousChapterPath;
  @JsonKey(name: 'next_chapter_path')
  final String? nextChapterPath;

  const DataChapterModel({
    required this.images,
    this.previousChapterPath,
    this.nextChapterPath,
  });

  factory DataChapterModel.fromJson(Map<String, dynamic> json) => _$DataChapterModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataChapterModelToJson(this);

  DataChapterEntity toEntity() => DataChapterEntity(
        images: images,
        previousChapterPath: previousChapterPath,
        nextChapterPath: nextChapterPath,
      );

  @override
  List<Object?> get props => [
        images,
        previousChapterPath,
        nextChapterPath,
      ];
}
