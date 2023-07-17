import 'dart:convert';

import 'package:http/http.dart';

import 'api_constants.dart';
import 'package:http/http.dart' as http;

class ApiClient {


  Future get(String path) async {

    final pth = _getPath(path);

    final response = await Client().get(
      pth,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Uri _getPath(String path) {
    return Uri.parse('${ApiConstants.baseUrl}$path');
  }
}
