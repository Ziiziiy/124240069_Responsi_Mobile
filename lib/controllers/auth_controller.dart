import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final String validUsername = '124240069';
  final String validPassword = '123';

  final usernameC = TextEditingController();
  final passwordC = TextEditingController();

  final username = ''.obs;

  @override
  void onInit() {
    loadUsername();
    super.onInit();
  }

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? '';
  }

  Future<String?> login() async {
    final inputUsername = usernameC.text.trim();
    final inputPassword = passwordC.text.trim();

    // Handling 1: input kosong
    if (inputUsername.isEmpty || inputPassword.isEmpty) {
      return 'Username dan password tidak boleh kosong';
    }

    // Handling 2: input salah
    if (inputUsername != validUsername || inputPassword != validPassword) {
      return 'Username atau password salah';
    }

    // simpan di SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', inputUsername);

    username.value = inputUsername;
    usernameC.clear();
    passwordC.clear();
    return null;
  }

  // Hapus data login
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('username');
    username.value = '';
  }
}