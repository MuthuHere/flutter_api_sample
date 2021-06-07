import 'package:dartz/dartz.dart';
import 'package:flutter_api_demo/base/base_repo.dart';
import 'package:flutter_api_demo/manager/auth_manager.dart';
import 'package:flutter_api_demo/response_model.dart';
import 'package:flutter_api_demo/service/api_constants.dart';
import 'package:flutter_api_demo/service/api_methods.dart';

class AuthRepo extends BaseRepository implements AuthManager {
  @override
  Future<Either<String, dynamic>> userLogin(Map<String, dynamic> input) async {
    var response = await super.networkProvider.callWebService(
          path: API_LOGIN,
          method: ApiMethod.POST,
          auth: super.header,
          body: input,
        );
    try {
      if (response != null) {
        return response;
      } else {
        return null;
      }
    } on Exception catch (e) {
      return null;
    }
  }

  @override
  Future<Either<String, List<ResponseModel>>> getUserDetails() async {
    var response = await super.networkProvider.callWebService(
          path: API_GET_USER,
          method: ApiMethod.GET,
          auth: super.header,
        );
    try {
      return response.fold((l) {
        return Left(l);
      }, (r) {
        final responseModel = responseModelFromJson(r.toString());
        return Right(responseModel);
      });
    } on Exception catch (e) {
      return null;
    }
  }
}
