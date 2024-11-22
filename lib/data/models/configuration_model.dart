import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/configuration_entity.dart';

part 'configuration_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ConfigurationModel extends Equatable {
  @JsonKey(name: 'app_version')
  final String appVersion;
  @JsonKey(name: 'base_komik_url')
  final String url;

  const ConfigurationModel({
    required this.appVersion,
    required this.url,
  });

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationModelToJson(this);

  ConfigurationEntity toEntity() => ConfigurationEntity(
        appVersion: appVersion,
        url: url,
      );

  @override
  List<Object?> get props => [
        appVersion,
        url,
      ];
}
