import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final safeTopPadding = topPadding > 0 ? topPadding + 24 : 64.0;

    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: safeTopPadding, left: 24, right: 24),
              child: Column(
                children: [
                  // ==========================================
                  // FOTO PROFIL ORANG REAL (BULAT ESTETIK)
                  // ==========================================
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.deepBlue, width: 2.5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=200&auto=format&fit=crop",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.deepBlue,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                            color: AppColors.accentGold,
                            shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt,
                            size: 14, color: AppColors.deepBlue),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text("Yepta Fredo",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepBlue)),
                  const SizedBox(height: 4),
                  Text("yeptafredo@mail.com",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 13)),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accentGold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.accentGold),
                    ),
                    child: const Text("🏅 GOLD MEMBER",
                        style: TextStyle(
                            color: AppColors.accentGold,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  children: [
                    _buildProfileItem(Icons.person_outline, "Edit Profil"),
                    _buildProfileItem(Icons.shield_outlined, "Keamanan Akun"),
                    _buildProfileItem(Icons.notifications_none, "Notifikasi"),
                    _buildProfileItem(Icons.help_outline, "Pusat Bantuan"),
                    _buildProfileItem(Icons.logout, "Keluar", isLogout: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title,
      {bool isLogout = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isLogout ? Colors.red.shade50 : const Color(0xfff5f7fb),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon,
            color: isLogout ? Colors.red : AppColors.deepBlue, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isLogout ? Colors.red : AppColors.deepBlue),
      ),
      trailing: isLogout
          ? null
          : Icon(Icons.chevron_right,
              color: Colors.black.withOpacity(0.3), size: 18),
      onTap: () {},
    );
  }
}
