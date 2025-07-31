import 'package:brimo_clone/presentation/pages/account_page.dart';
import 'package:brimo_clone/presentation/pages/activity_page.dart';
import 'package:brimo_clone/presentation/pages/home_page.dart';
import 'package:brimo_clone/presentation/pages/mutasi_page.dart';
import 'package:brimo_clone/presentation/pages/qris_scanner_page.dart'; // <-- Impor halaman QRIS
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final String userId;
  final int initialIndex;
  const MainScreen({super.key, required this.userId, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pageController = PageController(initialPage: pageViewIndex(_selectedIndex));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int pageViewIndex(int navIndex) {
    if (navIndex < 2) return navIndex;
    if (navIndex > 2) return navIndex - 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            if (index < 2) {
              _selectedIndex = index;
            } else {
              _selectedIndex = index + 1;
            }
          });
        },
        children: [
          HomePage(userId: widget.userId),
          MutasiPage(userId: widget.userId),
          ActivityPage(userId: widget.userId),
          AccountPage(userId: widget.userId),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildNavItem(icon: Icons.home_filled, label: 'Home', index: 0),
                  _buildNavItem(icon: Icons.receipt_long, label: 'Mutasi', index: 1),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildNavItem(icon: Icons.notifications, label: 'Aktivitas', index: 3),
                  _buildNavItem(icon: Icons.person, label: 'Akun', index: 4),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman QRIS Scanner
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QrisScannerPage()),
          );
        },
        backgroundColor: const Color(0xFF00529B),
        shape: const CircleBorder(),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    final bool isSelected = _selectedIndex == index;
    final Color color = isSelected ? Theme.of(context).primaryColor : Colors.grey;
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        _pageController.animateToPage(
          pageViewIndex(index),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}