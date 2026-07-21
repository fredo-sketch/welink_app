import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../dashboard/main_dashboard_shell.dart';
import 'register_step1_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BUNGKUS DENGAN CONTAINER UNTUK GRADASI BACKGROUND
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE2EDFF), // Biru muda lembut di paling atas
              Color(0xFFF8FAFC), // Transisi mulus ke putih/terang
              Colors.white, // Putih bersih di area tombol
            ],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 40),

                // ==========================================
                // 1. AREA TEXT & LOGO WELCOME
                // ==========================================
                Column(
                  children: [
                    // Kalimat Greeting di Paling Atas
                    const Text(
                      "Selamat datang di",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Logo Utama
                    Image.asset(
                      'assets/images/logo_welink.png',
                      width: 180,
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 32),

                    // Subtitle Deskripsi
                    Text(
                      "Dapatkan reward menarik dan penawaran eksklusif di berbagai merchant favoritmu di sekitarmu.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withValues(alpha: 0.6),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),

                // ==========================================
                // 2. TOMBOL AKSI (BOTTOM BUTTONS)
                // ==========================================
                Column(
                  children: [
                    // Tombol Masuk / Daftar
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterStep1Screen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation:
                              2, // Diberi sedikit shadow biar 'pop-out' dari background
                          shadowColor: AppColors.deepBlue.withOpacity(0.3),
                        ),
                        child: const Text(
                          "Masuk / Daftar",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tombol Jelajahi App
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MainDashboardShell()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.deepBlue,
                          backgroundColor: Colors.white
                              .withOpacity(0.8), // Sedikit transparan
                          side: const BorderSide(
                              color: AppColors.deepBlue, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Jelajahi App",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
