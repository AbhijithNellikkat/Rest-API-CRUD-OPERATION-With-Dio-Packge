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

  Future<bool> deleteUser(String userId) async {
    try {
      loading = true;
      notifyListeners();

      bool deleted = await userService.deleteUser(userId);
      if (deleted) {
        await fetchUsers();
      }

      loading = false;
      notifyListeners();
      return deleted;
    } catch (e) {
      loading = false;
      notifyListeners();
      log('$e');
      return false;
    }
  }

  Future<bool> editUser({required Users user}) async {
    try {
      loading = true;
      notifyListeners();

      bool edited = await userService.editUser(user: user);
      if (edited) {
        await fetchUsers();
      }

      loading = false;
      notifyListeners();
      return edited;
    } catch (e) {
      loading = false;
      notifyListeners();
      log('$e');
      return false;
    }
  }
}
