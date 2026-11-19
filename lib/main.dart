// main.dart -> PINTU MASUK APLIKASI
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/anime_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/favorite_controller.dart';
import 'pages/login_page.dart';
import 'pages/root_page.dart';
import 'utils/app_colors.dart';

void main() async {
  // Wajib karena main() memakai await
  WidgetsFlutterBinding.ensureInitialized();

  // Siapkan Hive dan buka box "favorites" (tempat menyimpan anime favorit)
  await Hive.initFlutter();
  await Hive.openBox('favorites');

  // Cek SharedPreferences: apakah user sudah pernah login?
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Daftarkan controller yang dipakai di banyak halaman (cukup sekali di sini)
  Get.put(AuthController());
  Get.put(FavoriteController());
  Get.put(AnimeController());

  runApp(MainApp(isLoggedIn: isLoggedIn));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    // GetMaterialApp = MaterialApp versi GetX
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Keripikroll',
      // Tema gelap dengan warna utama oranye
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(primary: kOrange),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        // Semua ElevatedButton: oranye & membulat
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kOrange,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
          ),
        ),
      ),
      // Sudah login -> Root, belum -> Login
      home: isLoggedIn ? RootPage() : LoginPage(),
    );
  }
}