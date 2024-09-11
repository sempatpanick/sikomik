// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationModel _$ConfigurationModelFromJson(Map<String, dynamic> json) =>
    ConfigurationModel(
      appVersion: json['app_version'] as String,
      url: json['base_komik_url'] as String,
    );

Map<String, dynamic> _$ConfigurationModelToJson(ConfigurationModel instance) =>
    <String, dynamic>{
      'app_version': instance.appVersion,
      'base_komik_url': instance.url,
    };
