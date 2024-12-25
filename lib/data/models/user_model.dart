import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/timestamp_converter.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String? id;
  final String? avatarUrl;
  final String? name;
  final String? email;
  final String? phoneNumber;
  @JsonKey(includeIfNull: false)
  @TimestampConverter()
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false)
  @TimestampConverter()
  DateTime? lastUpdated;

  UserModel({
    required this.id,
    required this.avatarUrl,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.createdAt,
    this.lastUpdated,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() => UserEntity(
        id: id,
        avatarUrl: avatarUrl,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        createdAt: createdAt,
        lastUpdated: lastUpdated,
      );
}
