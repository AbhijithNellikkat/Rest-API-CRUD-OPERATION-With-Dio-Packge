import 'dart:developer';

import 'package:crud_app_dio/models/user_model.dart';
import 'package:crud_app_dio/services/user_service.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final UserService userService = UserService();
  List<dynamic> users = [];
  bool loading = false;

  Future<void> fetchUsers() async {
    try {
      loading = true;
      notifyListeners();

      users = await userService.fetchUsers();

      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      log('$e');
    }
  }

  Future<void> createUser({required Users user}) async {
    try {
      loading = true;
      notifyListeners();

      await userService.createUser(user: user);
      await fetchUsers();
    } catch (e) {
      loading = false;
      notifyListeners();
      log('$e');
    }
  }
}
