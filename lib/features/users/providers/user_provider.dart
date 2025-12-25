import 'package:flutter/material.dart';

import '../../../core/api/api_service.dart';
import '../models/user_models.dart';

class UsersProvider extends ChangeNotifier {
  final UsersService _service = UsersService();

  List<UserModel> _users = [];
  List<UserModel> filteredUsers = [];

  bool isLoading = false;
  String? error;

  Future<void> loadUsers() async {
    try {
      isLoading = true;
      notifyListeners();

      _users = await _service.fetchUsers();
      filteredUsers = _users;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    filteredUsers = _users
        .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void addUser(UserModel user) {
    _users.add(user);
    filteredUsers = List.from(_users);
    notifyListeners();
  }



  UserModel getById(int id) =>
      _users.firstWhere((u) => u.id == id);
}
