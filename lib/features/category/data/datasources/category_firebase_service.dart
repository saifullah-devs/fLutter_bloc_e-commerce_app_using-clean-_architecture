import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/core/network/firebase_services_api.dart';

abstract class CategoryFirebaseService {
  Future<Either> getCategories();
}

class CategoryFirebaseServiceImpl extends CategoryFirebaseService {
  final FirebaseServicesApi _apiService = FirebaseServicesApi();

  @override
  Future<Either> getCategories() async {
    try {
      var returnData = await _apiService.readAll(path: 'categories');
      return Right(returnData);
    } catch (e) {
      return const Left('Please try again');
    }
  }
}
