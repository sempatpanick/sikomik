// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaModel _$MangaModelFromJson(Map<String, dynamic> json) => MangaModel(
      status: json['status'] as bool?,
      page: (json['page'] as num?)?.toInt(),
      maxPage: (json['max_page'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataMangaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MangaModelToJson(MangaModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'page': instance.page,
      'max_page': instance.maxPage,
      'data': instance.data,
    };

DataMangaModel _$DataMangaModelFromJson(Map<String, dynamic> json) =>
    DataMangaModel(
      title: json['title'] as String?,
      imageUrl: imageUrlFromJson(json['imageUrl']),
      chapter: json['chapter'] as num?,
      rating: json['rating'] as num?,
      status: json['status'] as String?,
      lastUpdated: json['lastUpdated'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$DataMangaModelToJson(DataMangaModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'imageUrl': imageUrlToJson(instance.imageUrl),
      'chapter': instance.chapter,
      'rating': instance.rating,
      'status': instance.status,
      'lastUpdated': instance.lastUpdated,
      'path': instance.path,
    };
