// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_comic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserComicModel _$UserComicModelFromJson(Map<String, dynamic> json) =>
    UserComicModel(
      comic: json['comic'] == null
          ? null
          : ComicDetailModel.fromJson(json['comic'] as Map<String, dynamic>),
      readChapters: (json['readChapters'] as List<dynamic>?)
          ?.map((e) => DataChapterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastReadChapter: json['lastReadChapter'] == null
          ? null
          : DataChapterModel.fromJson(
              json['lastReadChapter'] as Map<String, dynamic>),
      isFavorite: json['isFavorite'] as bool?,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      lastUpdated: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastUpdated'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$UserComicModelToJson(UserComicModel instance) =>
    <String, dynamic>{
      'comic': instance.comic,
      'readChapters': instance.readChapters,
      'lastReadChapter': instance.lastReadChapter,
      'isFavorite': instance.isFavorite,
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
      'lastUpdated': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.lastUpdated, const TimestampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
