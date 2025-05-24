import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _name;

  String get token => _token!;
  bool? get isloogedIn => _token != null;
  String get username => _name!;

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://192.168.1.32:3000/login');
    final loginresponse = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (loginresponse.statusCode == 200) {
      final loginData = json.decode(loginresponse.body);
      _token = loginData['token'];
      print(_token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _token!);
      await fetchprofile();
      notifyListeners();
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> fetchprofile() async {
    final url = Uri.parse('http://192.168.1.32:3000/profile');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      final profileData = json.decode(response.body);
      _name = profileData['user']['name'];
      print(_name);
      notifyListeners();
    } else {
      throw Exception('Failed to fetch profile');
    }
  }

  Future tryautologin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) return;
    _token = prefs.getString('token');
    await fetchprofile();
    notifyListeners();
  }

  Future logout() async {
    _token = null;
    _name = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }
}
