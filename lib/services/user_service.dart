import 'dart:developer';

import 'package:crud_app_dio/models/user_model.dart';
import 'package:dio/dio.dart';

class UserService {
  var apiUrl = "https://65c33f3039055e7482c06b43.mockapi.io/users";

  final Dio dio = Dio();

  Future<List<dynamic>> fetchUsers() async {
    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> users = (response.data)
            .map((userData) => Users.fromJson(userData))
            .toList();

        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      log("Error : $e");
      rethrow;
    }
  }
}
