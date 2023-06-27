// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) => ChapterModel(
      status: json['status'] as bool,
      data: DataChapterModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChapterModelToJson(ChapterModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

DataChapterModel _$DataChapterModelFromJson(Map<String, dynamic> json) =>
    DataChapterModel(
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      previousChapterPath: json['previous_chapter_path'] as String?,
      nextChapterPath: json['next_chapter_path'] as String?,
    );

Map<String, dynamic> _$DataChapterModelToJson(DataChapterModel instance) =>
    <String, dynamic>{
      'images': instance.images,
      'previous_chapter_path': instance.previousChapterPath,
      'next_chapter_path': instance.nextChapterPath,
    };
