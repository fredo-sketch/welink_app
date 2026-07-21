import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../dashboard/main_dashboard_shell.dart';
import 'register_step1_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.deepBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/images/logo_welink.png', height: 30),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              // Menghitung tinggi layar sisa agar layout pas presisi
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Title Halaman Masuk
                  const Text(
                    "Selamat Datang\nKembali",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                        height: 1.2),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 45,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.accentGold,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Field 1: Email / Username / No. Telp
                  const Text(
                    "Email atau Nomor Telepon",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                        fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Masukkan email atau nomor telepon",
                      prefixIcon: const Icon(Icons.account_circle_outlined,
                          color: AppColors.deepBlue),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Field 2: Password
                  const Text(
                    "Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                        fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Masukkan password Anda",
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: AppColors.deepBlue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Teks Lupa Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Nanti diisi alur Lupa Password jika diperlukan
                      },
                      child: const Text(
                        "Lupa Password?",
                        style: TextStyle(
                            color: AppColors.accentGold,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Tombol Utama: Masuk
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        // Jika berhasil masuk, lempar langsung ke halaman dashboard utama
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainDashboardShell()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: const Text("Masuk",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Opsi Navigasi ke Daftar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Belum punya akun? ",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 14)),
                      GestureDetector(
                        onTap: () {
                          // Pindah ke Halaman Register Step 1
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterStep1Screen()),
                          );
                        },
                        child: const Text(
                          "Daftar Sekarang",
                          style: TextStyle(
                              color: AppColors.deepBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Footer Legal & Copyright (Konsisten dengan Register)
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildFooterLink("Terms of Service"),
                            _buildDotDivider(),
                            _buildFooterLink("Privacy Policy"),
                            _buildDotDivider(),
                            _buildFooterLink("Help Center"),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "© 2026 WeLink. All rights reserved.",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.3)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 12,
            color: AppColors.deepBlue,
            fontWeight: FontWeight.w500));
  }

  Widget _buildDotDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Text("•", style: TextStyle(color: Colors.black.withOpacity(0.3))),
    );
  }
}
