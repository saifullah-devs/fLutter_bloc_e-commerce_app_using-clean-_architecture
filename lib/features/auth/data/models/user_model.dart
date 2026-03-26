import 'dart:convert';

import 'package:e_commerce_bloc/features/auth/domain/entities/user.dart';

class UserModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String image;
  final String gender;
  final String ageGroup;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.image,
    required this.gender,
    required this.ageGroup,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'image': image,
      'gender': gender,
      'age': ageGroup,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId']?.toString() ?? '',
      firstName: map['firstName']?.toString() ?? '',
      lastName: map['lastName']?.toString() ?? '',
      email: map['email']?.toString() ?? '',

      role: map['role']?.toString().toLowerCase().trim() ?? 'user',

      image: map['image']?.toString() ?? '',
      gender: map['gender']?.toString() ?? '',
      ageGroup: map['age']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      role: role,
      image: image,
      gender: gender,
      ageGroup: ageGroup,
    );
  }
}
