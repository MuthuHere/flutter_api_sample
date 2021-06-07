import 'package:dartz/dartz.dart';
import 'package:flutter_api_demo/response_model.dart';

abstract class AuthManager {
  Future<Either<String, dynamic>> userLogin(Map<String, dynamic> input);

  Future<Either<String, List<ResponseModel>>> getUserDetails();
}
