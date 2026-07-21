import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'register_step2_screen.dart';
import 'login_screen.dart'; // <-- Biar bisa pindah ke halaman login

class RegisterStep1Screen extends StatefulWidget {
  const RegisterStep1Screen({super.key});

  @override
  State<RegisterStep1Screen> createState() => _RegisterStep1ScreenState();
}

class _RegisterStep1ScreenState extends State<RegisterStep1Screen> {
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
        title: Image.asset(
          'assets/images/logo_welink.png', // Logo mini transparan di top bar
          height: 30,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Daftar Akun",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepBlue,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color:
                      AppColors.accentGold, // Garis aksen kuning khas Figma lo
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 30),

              // Form: Nama Lengkap
              _buildInputField(
                label: "Nama Lengkap",
                hint: "Masukkan nama lengkap Anda",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 20),

              // Form: Email
              _buildInputField(
                label: "Email",
                hint: "contoh@email.com",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Form: Password
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
                  hintText: "Buat password",
                  prefixIcon:
                      const Icon(Icons.lock_outline, color: AppColors.deepBlue),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Minimal 8 karakter",
                style: TextStyle(
                    fontSize: 12, color: Colors.black.withValues(alpha: 0.4)),
              ),

              const Spacer(),

              // Tombol Lanjut
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterStep2Screen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Lanjut",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Footer: Sudah punya akun
              // Footer: Sudah punya akun (Sekarang sudah aktif bisa diklik!)
              // Footer: Sudah punya akun (Versi Row + GestureDetector yang anti-gagal)
              // Footer: Sudah punya akun (Versi Hitbox Luas & Opaque)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior
                        .opaque, // Memaksa seluruh area padding sensitif sentuhan
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 12.0), // Gedein target klik jari
                      child: Text(
                        "Masuk disini",
                        style: TextStyle(
                          color: AppColors.deepBlue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget biar gak nulis ulang struktur TextField berkali-kali
  // Helper Widget di paling bawah file
  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
              fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon,
                color: AppColors
                    .deepBlue), // <-- Kata 'const' di depan Icon ini DIHAPUS
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
