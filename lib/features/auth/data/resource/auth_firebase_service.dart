import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/core/network/firebase_services_api.dart';
import 'package:e_commerce_bloc/features/auth/data/models/user_creation_req.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(UserCreationReq user);
  Future<Either> signin({required String email, required String password});
  Future<Either> sendPasswordResetEmail(String email);

  Future<Either> getAges();
  Future<Either> signout();
}

class AuthFirebaseServiceimpl extends AuthFirebaseService {
  final FirebaseServicesApi _apiService = FirebaseServicesApi();
  @override
  Future<Either> signup(UserCreationReq user) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email!,
            password: user.password!,
          );

      await _apiService.update(
        path: 'Users/${userCredential.user!.uid}',
        data: {
          'firstName': user.firstName,
          'lastName': user.lastName,
          'email': user.email,
          'gender': user.gender,
          'age': user.age,
        },
      );
      return const Right("Signup was successful!");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An Account already exist with thst email';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getAges() async {
    try {
      var returnData = await _apiService.read(
        path: 'ages',
        queryBuilder: (query) => query.orderBy('value', descending: false),
      );
      return Right(returnData);
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> signin({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Right("Signin was successful!");
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else {
        message = e.message ?? 'An unknown error occurred.';
      }

      return Left(message);
    } catch (e) {
      return const Left('Please try again later.');
    }
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right('Password reset email sent successfully');
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'An error occurred');
    } catch (e) {
      return const Left('Please try again later');
    }
  }

  @override
  Future<Either> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right("Sign Out was successful!");
    } catch (e) {
      return Left(e);
    }
  }
}
