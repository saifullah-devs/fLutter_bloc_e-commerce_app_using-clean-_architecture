import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/core/network/firebase_services_api.dart';
import 'package:e_commerce_bloc/features/auth/data/models/user_creation_req.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(UserCreationReq user);
  Future<Either> signin({required String email, required String password});
  Future<Either> sendPasswordResetEmail(String email);

  Future<Either> getAges();
  Future<Either> signout();
  Future<Either> isUserLoggedIn();
  Future<Either> getUser();
  Future<Either> galleryImagePicker();
  Future<Either> cameraImagePicker();
  Future<Either> removeImagePicker();
}

class AuthFirebaseServiceimpl extends AuthFirebaseService {
  final FirebaseServicesApi _apiService = FirebaseServicesApi();

  @override
  Future<Either> signup(UserCreationReq user) async {
    UserCredential? userCredential;
    try {
      // 1. Create Auth User
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email!,
            password: user.password!,
          );

      // String imageUrl = '';

      // // 2. Handle Image Upload (Only if not on Web and image exists)
      // if (!kIsWeb && user.image != null && user.image!.isNotEmpty) {
      //   final storageRef = FirebaseStorage.instance
      //       .ref()
      //       .child('UserImages')
      //       .child('${userCredential.user!.uid}.jpg');

      //   // Use putFile for Android/iOS
      //   await storageRef.putFile(File(user.image!));
      //   imageUrl = await storageRef.getDownloadURL();
      // }

      // 3. Save to Database
      await _apiService.update(
        path: 'Users/${userCredential.user!.uid}',
        data: {
          'userId': userCredential.user!.uid,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'email': user.email,
          'gender': user.gender,
          'age': user.age,
          'image': '',
          // 'image': imageUrl,
        },
      );

      return const Right("Signup was successful!");
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Auth failed');
    } catch (e) {
      if (userCredential?.user != null) {
        await userCredential!.user!.delete();
      }
      return Left('Error: ${e.toString()}');
    }
  }

  @override
  Future<Either> getAges() async {
    try {
      var returnData = await _apiService.readAll(
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

  @override
  Future<Either> isUserLoggedIn() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return const Left('Authentication error');
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) return const Left("No user logged in");

      var userData = await _apiService.readOne(path: 'Users/${user.uid}');

      if (userData == null) return const Left("User data not found");

      return Right(userData);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> galleryImagePicker() async {
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image from gallery
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        return Right(File(image.path));
      } else {
        return const Left("No image selected");
      }
    } catch (e) {
      return const Left("Failed to pick image");
    }
  }

  @override
  Future<Either> cameraImagePicker() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        return Right(File(image.path));
      } else {
        return const Left("No image selected");
      }
    } catch (e) {
      return const Left("Failed to pick image");
    }
  }

  @override
  Future<Either> removeImagePicker() async {
    try {
      // Returning an empty string signifies to the Bloc that the image was cleared
      return const Right('');
    } catch (e) {
      return const Left("Failed to clear image");
    }
  }
}
