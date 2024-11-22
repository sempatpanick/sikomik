import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? avatarUrl;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? lastUpdated;

  const UserEntity({
    this.id,
    this.avatarUrl,
    this.name,
    this.email,
    this.phoneNumber,
    this.createdAt,
    this.lastUpdated,
  });

  UserModel toModel() => UserModel(
        id: id,
        avatarUrl: avatarUrl,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        createdAt: createdAt,
        lastUpdated: lastUpdated,
      );

  @override
  List<Object?> get props => [
        id,
        avatarUrl,
        name,
        email,
        phoneNumber,
        createdAt,
        lastUpdated,
      ];
}
