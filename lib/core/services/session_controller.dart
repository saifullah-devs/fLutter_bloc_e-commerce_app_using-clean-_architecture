// import 'dart:convert';
// import 'package:flutter/widgets.dart';
// import 'package:movie_app_bloc/features/auth/data/models/user_model.dart';
// import '../dependency_injection.dart';
// import '../storage/local_storage.dart';

// class SessionController {
//   static final SessionController _instance = SessionController._internal();

//   factory SessionController() {
//     return _instance;
//   }

//   SessionController._internal();

//   final LocalStorage _localStorage = getIt<LocalStorage>();

//   UserModel? user;
//   bool isLoggedIn = false;

//   Future<void> saveUserInPreferences(UserModel user) async {
//     await _localStorage.setValue('user_data', jsonEncode(user));
//     await _localStorage.setValue('isLoggedIn', 'true');

//     this.user = user;
//     isLoggedIn = true;
//   }

//   Future<UserModel?> getUserFromPreferences() async {
//     try {
//       String? userData = await _localStorage.getValue('user_data');
//       String? isLoginString = await _localStorage.getValue('isLoggedIn');

//       if (userData != null) {
//         user = UserModel.fromJson(jsonDecode(userData));
//         isLoggedIn = (isLoginString == 'true');
//         return user;
//       } else {
//         isLoggedIn = false;
//         user = null;
//       }
//     } catch (e) {
//       debugPrint('Error retrieving user data: $e');
//       isLoggedIn = false;
//       user = null;
//     }
//     return null;
//   }

//   Future<void> clearSession() async {
//     await _localStorage.clearValue('user_data');
//     await _localStorage.setValue('isLoggedIn', 'false');

//     user = null;
//     isLoggedIn = false;
//   }
// }
