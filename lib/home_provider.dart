import 'package:flutter/material.dart';
import 'package:flutter_api_demo/response_model.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<ResponseModel> _list;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<ResponseModel> get list => _list;

  set list(List<ResponseModel> value) {
    _list = value;
    notifyListeners();
  }

  Future<void> getUser() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/users');

    if (response != null && response.body != null) {
      final responseModel = responseModelFromJson(response.body);
      this.list = responseModel;
    }
  }
}
