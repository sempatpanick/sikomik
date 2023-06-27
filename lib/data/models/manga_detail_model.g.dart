// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaDetailModel _$MangaDetailModelFromJson(Map<String, dynamic> json) =>
    MangaDetailModel(
      status: json['status'] as bool,
      data: DataMangaDetailModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MangaDetailModelToJson(MangaDetailModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

DataMangaDetailModel _$DataMangaDetailModelFromJson(
        Map<String, dynamic> json) =>
    DataMangaDetailModel(
      title: json['title'] as String,
      description: json['description'] as String,
      rating: json['rating'] as num,
      informations: (json['informations'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      genres: (json['genres'] as List<dynamic>)
          .map((e) =>
              GenreDataMangaDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) =>
              ChapterDataMangaDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      imagePath: json['image_path'] as String,
    );

Map<String, dynamic> _$DataMangaDetailModelToJson(
        DataMangaDetailModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'rating': instance.rating,
      'informations': instance.informations,
      'genres': instance.genres,
      'chapters': instance.chapters,
      'image_path': instance.imagePath,
    };

GenreDataMangaDetailModel _$GenreDataMangaDetailModelFromJson(
        Map<String, dynamic> json) =>
    GenreDataMangaDetailModel(
      name: json['name'] as String,
      path: json['path'] as String,
    );

Map<String, dynamic> _$GenreDataMangaDetailModelToJson(
        GenreDataMangaDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
    };

ChapterDataMangaDetailModel _$ChapterDataMangaDetailModelFromJson(
        Map<String, dynamic> json) =>
    ChapterDataMangaDetailModel(
      chapter: json['chapter'] as num,
      uploadAt: json['upload_at'] as String,
      path: json['path'] as String,
    );

Map<String, dynamic> _$ChapterDataMangaDetailModelToJson(
        ChapterDataMangaDetailModel instance) =>
    <String, dynamic>{
      'chapter': instance.chapter,
      'upload_at': instance.uploadAt,
      'path': instance.path,
    };
