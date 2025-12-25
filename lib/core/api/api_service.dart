import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../features/users/models/user_models.dart';

class UsersService {
  Future<List<UserModel>> fetchUsers() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List;
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
