// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_comic_chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserComicChapterModel _$UserComicChapterModelFromJson(
        Map<String, dynamic> json) =>
    UserComicChapterModel(
      id: json['id'] as String?,
      chapter: json['chapter'] == null
          ? null
          : DataChapterModel.fromJson(json['chapter'] as Map<String, dynamic>),
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      lastUpdated: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastUpdated'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$UserComicChapterModelToJson(
        UserComicChapterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.chapter?.toJson() case final value?) 'chapter': value,
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.createdAt, const TimestampConverter().toJson)
          case final value?)
        'createdAt': value,
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.lastUpdated, const TimestampConverter().toJson)
          case final value?)
        'lastUpdated': value,
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
