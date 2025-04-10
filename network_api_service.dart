import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:sy_order/service/api/app_exceptions.dart';

class NetworkApiService {
  Future getApi(String url) async {
    dynamic responseJson;
    try {
      Response response = await get(Uri.parse(url));
      responseJson = apiResponse(response);
    } catch (e) {
      debugPrint(e.toString());
    }
    return responseJson;
  }

  Future postApi(String url, data) async {
    try {
      Response response = await post(Uri.parse(url), body: data);
      return apiResponse(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  dynamic apiResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        throw UnAuthorizedException(message: response.body.toString());
      default:
        throw FetchDataException(message: 'Error During Communication');
    }
  }
}
