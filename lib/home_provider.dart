import 'package:flutter/material.dart';
import 'package:flutter_api_demo/base/base_provider.dart';
import 'package:flutter_api_demo/repo/auth_repo.dart';
import 'package:flutter_api_demo/response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends BaseProvider {
  //repos
  AuthRepo _authRepo = AuthRepo();
  List<ResponseModel> _list;

  List<ResponseModel> get list => _list;

  set list(List<ResponseModel> value) {
    _list = value;
    notifyListeners();
  }

  Future<void> getUser() async {
    final response = await _authRepo.getUserDetails();
    response.fold((l) {
      Get.snackbar('TestApp)', '$l');
    }, (r) {
      this.list = r;
    });
  }
}
