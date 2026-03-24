import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/features/auth/data/models/user_creation_req.dart';
import 'package:e_commerce_bloc/features/auth/data/resource/auth_firebase_service.dart';
import 'package:e_commerce_bloc/features/auth/domain/repository/auth.dart';
import 'package:e_commerce_bloc/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signup(UserCreationReq user) async {
    return await sl<AuthFirebaseService>().signup(user);
  }

  @override
  Future<Either> getAges() async {
    return await sl<AuthFirebaseService>().getAges();
  }

  @override
  Future<Either> signin(Map<String, dynamic> params) async {
    return await sl<AuthFirebaseService>().signin(
      email: params['email'],
      password: params['password'],
    );
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    return await sl<AuthFirebaseService>().sendPasswordResetEmail(email);
  }

  @override
  Future<Either> signout() async {
    return await sl<AuthFirebaseService>().signout();
  }
}
