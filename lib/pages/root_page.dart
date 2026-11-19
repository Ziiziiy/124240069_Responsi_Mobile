import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class RootPage extends StatefulWidget {
  final bool showLoginSuccess;

  const RootPage({super.key, this.showLoginSuccess = false});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  final RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [HomePage(), FavoritePage(), ProfilePage()];

  @override
  void initState() {
    super.initState();
    if (widget.showLoginSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        // Popup sederhana di bawah layar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login berhasil')),
        );
      });
    }
  }

  Widget _title() {
    if (selectedIndex.value == 0) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.radio_button_checked, size: 22, color: kOrange),
          SizedBox(width: 8),
          Text(
            'Keripikroll',
            style: TextStyle(
              color: kOrange,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      );
    }
    return Text(selectedIndex.value == 1 ? 'Daftar Favorit' : 'Profil');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: _title(),
          centerTitle: selectedIndex.value == 2,
        ),
        body: IndexedStack(index: selectedIndex.value, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex.value,
          onTap: (value) => selectedIndex.value = value,
          backgroundColor: Colors.black,
          selectedItemColor: kOrange,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorit'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
