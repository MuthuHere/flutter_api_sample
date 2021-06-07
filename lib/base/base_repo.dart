import 'package:flutter_api_demo/service/api_client.dart';

class BaseRepository {
  final networkProvider = ApiClient();
  Map<String, String> header = {
    "Content-Type": "application/json",
  };
}