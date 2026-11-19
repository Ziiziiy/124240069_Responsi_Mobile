import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../utils/app_colors.dart';
import 'root_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController controller = Get.find<AuthController>();

  InputDecoration _inputStyle(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      prefixIcon: Icon(icon, color: Colors.grey, size: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white54),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: kOrange, width: 2),
      ),
    );
  }

  Future<void> _onLogin(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    final error = await controller.login();

    if (error == null) {
      Get.offAll(() => RootPage(showLoginSuccess: true));
    } else {
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Login gagal! $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.radio_button_checked, size: 72, color: kOrange),
              const SizedBox(height: 12),
              const Text(
                'Keripikroll',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 36),

              // Input username
              TextField(
                controller: controller.usernameC,
                decoration: _inputStyle('Username', Icons.person),
              ),
              const SizedBox(height: 12),

              // Input password 
              TextField(
                controller: controller.passwordC,
                obscureText: true,
                decoration: _inputStyle('Password', Icons.lock),
              ),
              const SizedBox(height: 22),

              // Tombol login
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () => _onLogin(context),
                  child: const Text('Login', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
