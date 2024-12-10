import 'dart:convert';

import 'package:github_info/services/log_service.dart';
import 'package:dio/dio.dart';
import '../model/post_model.dart';

class Network {
  static String BASE = "https://jsonplaceholder.typicode.com";
  static Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8'};

  /* API Endpoints */
  static String API_LIST = "/posts";
  static String API_CREATE = "/posts";
  static String API_UPDATE = "/posts/"; // {id}
  static String API_DELETE = "/posts/"; // {id}

  static Dio dio = Dio();

  // GET so'rovi
  static Future<String?> GET(String api, Map<String, String> params) async {
    try {
      Response response = await dio.get(BASE + api, queryParameters: params, options: Options(headers: headers));
      if (response.statusCode == 200) {
        LogService.d(response.data.toString());
        return response.data.toString();
      }
    } catch (e) {
      LogService.d("GET request failed: $e");
    }
    return null;
  }

  // POST so'rovi
  static Future<String?> POST(String api, Map<String, String> params) async {
    try {
      Response response = await dio.post(BASE + api,
          data: jsonEncode(params), options: Options(headers: headers));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Yaratildi');
        return response.data.toString();
      }
    } catch (e) {
      LogService.d("POST request failed: $e");
    }
    return null;
  }

  // PUT so'rovi
  static Future<String?> PUT(String api, Map<String, String> params) async {
    try {
      Response response = await dio.put(BASE + api,
          data: jsonEncode(params), options: Options(headers: headers));
      if (response.statusCode == 200) {
        LogService.d("Yangilandi");
        return response.data.toString();
      }
    } catch (e) {
      LogService.d("PUT request failed: $e");
    }
    return null;
  }

  // DELETE so'rovi
  static Future<String?> DEL(String api, Map<String, String> params) async {
    try {
      Response response = await dio.delete(BASE + api,
          data: jsonEncode(params), options: Options(headers: headers));
      if (response.statusCode == 200) {
        print('Ajoyib');
        return response.data.toString();
      }
    } catch (e) {
      LogService.d("DELETE request failed: $e");
    }
    return null;
  }

  /* HTTP Params */

  static Map<String, String> paramsEmpty() {
    return {};
  }

  static Map<String, String> paramsCreate(Post post) {
    return {
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    };
  }

  static Map<String, String> paramsUpdate(Post post) {
    return {
      'id': post.id.toString(),
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    };
  }

  // Parsing response to Post list
  static List<Post> parsePostList(String response) {
    dynamic json = jsonDecode(response);
    var data = List<Post>.from(json.map((x) => Post.fromJson(x)));
    return data;
  }
}
