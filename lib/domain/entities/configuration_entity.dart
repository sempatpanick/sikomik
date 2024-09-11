import 'package:equatable/equatable.dart';

import '../../data/models/configuration_model.dart';

class ConfigurationEntity extends Equatable {
  final String appVersion;
  final String url;

  const ConfigurationEntity({
    required this.appVersion,
    required this.url,
  });

  ConfigurationModel toModel() => ConfigurationModel(
        appVersion: appVersion,
        url: url,
      );

  @override
  List<Object?> get props => [
        appVersion,
        url,
      ];
}
