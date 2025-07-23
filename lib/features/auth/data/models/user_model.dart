import 'package:json_annotation/json_annotation.dart';
import 'package:shartflix/features/auth/domain/entities/user_entitiy.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.photoUrl,
    super.token = "",
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  
}
