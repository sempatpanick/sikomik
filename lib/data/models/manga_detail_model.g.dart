// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaDetailModel _$MangaDetailModelFromJson(Map<String, dynamic> json) =>
    MangaDetailModel(
      status: json['status'] as bool?,
      data: json['data'] == null
          ? null
          : DataMangaDetailModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MangaDetailModelToJson(MangaDetailModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

DataMangaDetailModel _$DataMangaDetailModelFromJson(
        Map<String, dynamic> json) =>
    DataMangaDetailModel(
      title: json['title'] as String?,
      titleIndonesia: json['titleIndonesia'] as String?,
      imageUrl: imageUrlFromJson(json['imageUrl']),
      thumbnailUrl: imageUrlFromJson(json['thumbnailUrl']),
      synopsis: json['synopsis'] as String?,
      type: json['type'] as String?,
      storyConcept: json['storyConcept'] as String?,
      author: json['author'] as String?,
      status: json['status'] as String?,
      rating: json['rating'] as num?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) =>
              GenreDataMangaDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      chapters: (json['chapters'] as List<dynamic>?)
          ?.map((e) =>
              ChapterDataMangaDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataMangaDetailModelToJson(
        DataMangaDetailModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'titleIndonesia': instance.titleIndonesia,
      'imageUrl': imageUrlToJson(instance.imageUrl),
      'thumbnailUrl': imageUrlToJson(instance.thumbnailUrl),
      'synopsis': instance.synopsis,
      'type': instance.type,
      'storyConcept': instance.storyConcept,
      'author': instance.author,
      'status': instance.status,
      'rating': instance.rating,
      'genres': instance.genres,
      'chapters': instance.chapters,
    };

GenreDataMangaDetailModel _$GenreDataMangaDetailModelFromJson(
        Map<String, dynamic> json) =>
    GenreDataMangaDetailModel(
      name: json['name'] as String?,
      path: json['path'] as String?,
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
      name: json['name'] as String?,
      chapter: json['chapter'] as num?,
      uploadedDate: json['uploadedDate'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$ChapterDataMangaDetailModelToJson(
        ChapterDataMangaDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'chapter': instance.chapter,
      'uploadedDate': instance.uploadedDate,
      'path': instance.path,
    };
