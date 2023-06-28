import 'package:equatable/equatable.dart';

import '../../data/models/configuration_model.dart';

class ConfigurationEntity extends Equatable {
  final String appVersion;
  final String baseKomikUrl;

  const ConfigurationEntity({
    required this.appVersion,
    required this.baseKomikUrl,
  });

  ConfigurationModel toModel() => ConfigurationModel(
        appVersion: appVersion,
        baseKomikUrl: baseKomikUrl,
      );

  @override
  List<Object?> get props => [
        appVersion,
        baseKomikUrl,
      ];
}
