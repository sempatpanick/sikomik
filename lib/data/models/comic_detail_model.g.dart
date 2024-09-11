// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicDetailModel _$ComicDetailModelFromJson(Map<String, dynamic> json) =>
    ComicDetailModel(
      status: json['status'] as bool?,
      data: json['data'] == null
          ? null
          : DataComicDetailModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicDetailModelToJson(ComicDetailModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

DataComicDetailModel _$DataComicDetailModelFromJson(
        Map<String, dynamic> json) =>
    DataComicDetailModel(
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
              GenreDataComicDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      chapters: (json['chapters'] as List<dynamic>?)
          ?.map((e) =>
              ChapterDataComicDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataComicDetailModelToJson(
        DataComicDetailModel instance) =>
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

GenreDataComicDetailModel _$GenreDataComicDetailModelFromJson(
        Map<String, dynamic> json) =>
    GenreDataComicDetailModel(
      name: json['name'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$GenreDataComicDetailModelToJson(
        GenreDataComicDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
    };

ChapterDataComicDetailModel _$ChapterDataComicDetailModelFromJson(
        Map<String, dynamic> json) =>
    ChapterDataComicDetailModel(
      name: json['name'] as String?,
      chapter: json['chapter'] as num?,
      uploadedDate: json['uploadedDate'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$ChapterDataComicDetailModelToJson(
        ChapterDataComicDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'chapter': instance.chapter,
      'uploadedDate': instance.uploadedDate,
      'path': instance.path,
    };
