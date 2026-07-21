import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'otp_verification_screen.dart';

class RegisterStep2Screen extends StatefulWidget {
  const RegisterStep2Screen({super.key});

  @override
  State<RegisterStep2Screen> createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  bool _obscureConfirmPassword = true;
  final TextEditingController _dateController = TextEditingController();

  // Fungsi interaktif untuk menampilkan date picker premium
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text =
            "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

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
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Lengkapi Profil",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.accentGold,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Text(
                        "Langkah 2 dari 3",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withValues(alpha: 0.5),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Field: Username
                  _buildInputField(
                    label: "Username",
                    hint: "Pilih username unik",
                    icon: Icons.account_circle_outlined,
                  ),
                  const SizedBox(height: 16),

                  // Field: Tanggal Lahir (Dengan Aksi Tap Calendar)
                  const Text(
                    "Tanggal Lahir",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                        fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      hintText: "mm/dd/yyyy",
                      prefixIcon: const Icon(Icons.calendar_month_outlined,
                          color: AppColors.deepBlue),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Field: Nomor Telp
                  _buildInputField(
                    label: "Nomor Telp",
                    hint: "+62 8xx xxxx xxxx",
                    icon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  // Field: Confirm Password
                  const Text(
                    "Confirm Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                        fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: "Ulangi password Anda",
                      prefixIcon: const Icon(Icons.lock_clock_outlined,
                          color: AppColors.deepBlue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(() =>
                            _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                  ),

                  const Spacer(),

                  // Tombol Daftar Sekarang
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const OtpVerificationScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: const Text("Daftar Sekarang",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Footer Dokumen & Copyright Sesuai Figma
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
                              color: Colors.black.withValues(alpha: 0.3)),
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

  Widget _buildInputField(
      {required String label,
      required String hint,
      required IconData icon,
      TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.deepBlue,
                fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: AppColors.deepBlue),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
          ),
        ),
      ],
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
      child: Text("•",
          style: TextStyle(color: Colors.black.withValues(alpha: 0.3))),
    );
  }
}
