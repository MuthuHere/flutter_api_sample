import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'api_methods.dart';

class ApiClient {
  final String _tagRequest = '====== Request =====>';
  final String _tagResponse = '====== Response =====>';

  Future<Either<String, dynamic>> callWebService({
    @required String path,
    Encoding encoding,
    @required ApiMethod method,
    Map<String, dynamic> body,
    Map<String, dynamic> auth,
  }) async {
    Map<String, String> headers = Map();
    headers[HttpHeaders.contentTypeHeader] = "application/json";

    /// Check internet connection
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return Left(('Please check your internet connection'));
    }

    var responseData;
    final url = API_BASE_URL + path;
    debugPrint(' $_tagRequest  $method   $url \n $headers');
    debugPrint('$jsonEncode($body)');

    switch (method) {
      case ApiMethod.GET:
        {
          responseData = await http.get(url, headers: headers);
        }
        break;
      case ApiMethod.POST:
        {
          responseData =
              await http.post(url, headers: headers, body: json.encode(body));
        }
        break;
      case ApiMethod.UPDATE:
        {
          responseData =
              await http.patch(url, headers: headers, body: json.encode(body));
          break;
        }
      case ApiMethod.PUT:
        {
          responseData =
              await http.put(url, headers: headers, body: json.encode(body));
          break;
        }
      case ApiMethod.DELETE:
        {
          responseData = await http.delete(
            url,
            headers: headers,
          );
        }
        break;
    }

    debugPrint(
      '$_tagResponse ${responseData.statusCode} - $url \n ${responseData.body}',
    );
    if (responseData.statusCode == HttpStatus.ok) {
      return Right(responseData.body);
    } else {
      return Left(('Oops, something went wrong. Please try again later.'));
      // return Left(Exception('Response Code: ${responseData.statusCode}- Service Unavailable!'));
    }
  }
}
