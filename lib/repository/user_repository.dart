import 'dart:convert';

import 'package:riverpod_practice/core.dart';
import 'package:riverpod_practice/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_practice/utils/logger.dart';


class UserRepository {
  Future<User> getUser() async {
    logRepository("get User");
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulate a network request
    final response = await http.get(Uri.http(baseUrl, "/user"));
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return User.fromJson(json);
  }
}