import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/favorite_controller.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final AuthController authC = Get.find<AuthController>();
  final FavoriteController favoriteC = Get.find<FavoriteController>();

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 46,
              backgroundColor: Colors.grey[800],
              child: Icon(Icons.person, size: 50, color: Colors.grey[300]),
            ),
            const SizedBox(height: 28),

            // Username dari SharedPreferences
            Obx(() => _row('Username:', authC.username.value)),

            // Jumlah favorit 
            Obx(() => _row('Anime Disukai:', '${favoriteC.favorites.length}')),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () async {
                  await authC.logout(); 
                  Get.offAll(() => LoginPage()); 
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}