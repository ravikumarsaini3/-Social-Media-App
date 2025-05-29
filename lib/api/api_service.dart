import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/exceptions/app_exceptions.dart';
import 'package:social_media_app/models/comment_model.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/models/user_model.dart';

class ApiService {
  Dio dio = Dio();
  String postUrl = "https://jsonplaceholder.typicode.com/posts";
  String commentUrl = "https://jsonplaceholder.typicode.com/comments";
  String userUrl = "https://jsonplaceholder.typicode.com/users";

  Future<List<PostModel>> fetchPost() async {
    try {
      final response = await dio.get(
        postUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'User-Agent': 'PostmanRuntime/7.32.3',
          },
          validateStatus:
              (status) =>
                  status != null && status < 500, // handle 403 gracefully
        ),
      );

      List data = handleResponse(response);

      return data.map((e) => PostModel.fromJson(e)).toList();
    } on DioException catch (e) {
      return Future.error(_handleError(e));
    }
  }

  Future<List<CommentModel>> fetchComment() async {
    try {
      final response = await dio.get(
        commentUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'User-Agent': 'PostmanRuntime/7.32.3',
            // Add Authorization if needed
          },
          validateStatus:
              (status) =>
                  status != null && status < 500, // handle 403 gracefully
        ),
      );

      List data = handleResponse(response);
      print(data);
      return data.map((e) => CommentModel.fromJson(e)).toList();
    } on DioException catch (e) {
      return Future.error(_handleError(e));
    }
  }

  Future<List<UserModel>> fetchUser() async {
    try {
      final response = await dio.get(
        userUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'User-Agent': 'PostmanRuntime/7.32.3',
            // Add Authorization if needed
          },
          validateStatus:
              (status) =>
                  status != null && status < 500, // handle 403 gracefully
        ),
      );

      List data = handleResponse(response);

      return data.map((e) => UserModel.fromJson(e)).toList();
    } on DioException catch (e) {
      return Future.error(_handleError(e));
    }
  }
}

dynamic handleResponse(response) {
  switch (response.statusCode) {
    case 200:
      return response.data;
    case 400:
      throw BadRequestException('Invalid Request');

    case 408:
      throw TimeOutException("Request timed out");
    case 504:
      throw InvalidResponse("Server error");
    default:
      throw AppExceptions("Unexpected error", "Error ${response.statusCode}: ");
  }
}

Exception _handleError(DioException error) {
  print("Dio Error Type: ${error.type}, Message: ${error.message}");
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return TimeOutException("Request timed out");
    case DioExceptionType.badResponse:
      return InvalidResponse("Server error");
    case DioExceptionType.cancel:
      return TimeOutException("Request cancelled");
    default:
      return AppExceptions("Unexpected error", "Error: ${error.message}");
  }
}
