// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'local_storage.dart';

// class SecureStorageImpl implements LocalStorage {
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();

//   @override
//   Future<bool> setValue(String key, String value) async {
//     await _storage.write(key: key, value: value);
//     return true;
//   }

//   @override
//   Future<dynamic> getValue(String key) async {
//     return await _storage.read(key: key);
//   }

//   @override
//   Future<bool> clearValue(String key) async {
//     await _storage.delete(key: key);
//     return true;
//   }
// }
