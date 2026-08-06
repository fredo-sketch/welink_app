import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'home_screen.dart';
import '../explore/explore_screen.dart';
import '../scan/customer_qr_screen.dart';
import '../reward/reward_screen.dart';
import '../menu/profile_screen.dart';

class MainDashboardShell extends StatefulWidget {
  const MainDashboardShell({super.key});

  @override
  State<MainDashboardShell> createState() => _MainDashboardShellState();
}

class _MainDashboardShellState extends State<MainDashboardShell> {
  int _currentIndex = 0;

  // List halaman utama sesuai urutan tab navbar
  final List<Widget> _pages = [
    const HomeScreen(), // Index 0
    const ExploreScreen(), // Index 1
    const CustomerQrScreen(), // Index 2
    const RewardScreen(), // <-- UPDATE: Sekarang memanggil RewardScreen asli!
    const ProfileScreen(), // Index 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // KUNCI UTAMA: Agar konten screen bisa nge-scroll tembus ke belakang navbar kapsul melayang
      extendBody: true,

      // IndexedStack menjaga state halaman biar gak nge-refresh pas pindah tab
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      // Membuat Kapsul Bottom Navigation Bar Melayang sesuai desain UI Welink
      bottomNavigationBar: _buildBottomNavbar(),
    );
  }

  Widget _buildBottomNavbar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      height: 68,
      decoration: BoxDecoration(
        color: AppColors.deepBlue,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded, "HOME"),
          _buildNavItem(1, Icons.explore_rounded, "EXPLORE"),
          _buildScanItem(), // Tombol Scan Tengah Melayang
          _buildNavItem(3, Icons.emoji_events_rounded, "REWARD"),
          _buildNavItem(4, Icons.person_rounded, "PROFILE"),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.4),
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.4),
              fontSize: 8,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanItem() {
    return InkWell(
      onTap: () => setState(() => _currentIndex = 2),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        transform: Matrix4.translationValues(
            0, -12, 0), // Mengangkat tombol SCAN ke atas navbar
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: AppColors.deepBlue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 22),
            SizedBox(height: 2),
            Text(
              "SCAN",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
