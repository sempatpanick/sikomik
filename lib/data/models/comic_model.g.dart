// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicModel _$ComicModelFromJson(Map<String, dynamic> json) => ComicModel(
      status: json['status'] as bool?,
      page: (json['page'] as num?)?.toInt(),
      maxPage: (json['max_page'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataComicModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicModelToJson(ComicModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'page': instance.page,
      'max_page': instance.maxPage,
      'data': instance.data,
    };

DataComicModel _$DataComicModelFromJson(Map<String, dynamic> json) =>
    DataComicModel(
      title: json['title'] as String?,
      imageUrl: imageUrlFromJson(json['imageUrl']),
      chapter: json['chapter'] as num?,
      rating: json['rating'] as num?,
      status: json['status'] as String?,
      lastUpdated: json['lastUpdated'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$DataComicModelToJson(DataComicModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'imageUrl': imageUrlToJson(instance.imageUrl),
      'chapter': instance.chapter,
      'rating': instance.rating,
      'status': instance.status,
      'lastUpdated': instance.lastUpdated,
      'path': instance.path,
    };
