// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) => ChapterModel(
      status: json['status'] as bool?,
      data: json['data'] == null
          ? null
          : DataChapterModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChapterModelToJson(ChapterModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

DataChapterModel _$DataChapterModelFromJson(Map<String, dynamic> json) =>
    DataChapterModel(
      title: json['title'] as String?,
      chapter: (json['chapter'] as num?)?.toInt(),
      uploadedDate: json['uploadedDate'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DataChapterModelToJson(DataChapterModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'chapter': instance.chapter,
      'uploadedDate': instance.uploadedDate,
      'images': instance.images,
    };
