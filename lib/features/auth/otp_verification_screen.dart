import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../dashboard/main_dashboard_shell.dart';
import 'dart:async'; // Modul wajib untuk Timer

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<String> _otpCodes = ["", "", "", "", ""];

  // ==========================================
  // LOGIK TIMER LIVE COUNTER
  // ==========================================
  Timer? _timer;
  int _startSeconds = 45; // Hitung mundur dari 45 detik

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startSeconds == 0) {
        setState(() {
          _timer?.cancel();
        });
      } else {
        setState(() {
          _startSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Mencegah kebocoran memori (memory leak)
    super.dispose();
  }
  // ==========================================

  void _onKeypadPressed(String value) {
    setState(() {
      for (int i = 0; i < _otpCodes.length; i++) {
        if (_otpCodes[i].isEmpty) {
          _otpCodes[i] = value;
          break;
        }
      }
    });

    if (!_otpCodes.contains("")) {
      _verifyOtpSuccess();
    }
  }

  void _onDeletePressed() {
    setState(() {
      for (int i = _otpCodes.length - 1; i >= 0; i--) {
        if (_otpCodes[i].isNotEmpty) {
          _otpCodes[i] = "";
          break;
        }
      }
    });
  }

  void _verifyOtpSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Verifikasi Berhasil! Selamat Datang."),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainDashboardShell()),
      (route) => false,
    );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Verifikasi OTP",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue),
                  ),
                  const SizedBox(height: 4),

                  // LINE PROGRESS BAR YANG SUDAH DIBETULKAN (ANTI-CRASH)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 16),
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.black
                                .withOpacity(0.1), // Track abu-abu dasar
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3, // Langkah 3 dari 3 -> Penuh (100%)
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.accentGold,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              const Expanded(
                                  flex: 0,
                                  child:
                                      SizedBox()), // Sisa 0 karena sudah langkah terakhir
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "Langkah 3 dari 3",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Text(
              "Kode telah dikirim ke\n0812-XXXX-XXXX",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black.withOpacity(0.6),
                  height: 1.4),
            ),
            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(5, (index) => _buildOtpBox(_otpCodes[index])),
            ),
            const SizedBox(height: 24),

            // LIVE TIMER DENGAN DATA DINAMIS VARIABLE
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                children: [
                  const TextSpan(text: "Kirim ulang dalam "),
                  TextSpan(
                      text: "00:${_startSeconds.toString().padLeft(2, '0')}",
                      style: const TextStyle(
                          color: AppColors.accentGold,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const Spacer(),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
              color: Colors.white.withOpacity(0.5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ["1", "2", "3"]
                        .map((val) => _buildKeypadButton(val))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ["4", "5", "6"]
                        .map((val) => _buildKeypadButton(val))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ["7", "8", "9"]
                        .map((val) => _buildKeypadButton(val))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 60, height: 60),
                      _buildKeypadButton("0"),
                      IconButton(
                        onPressed: _onDeletePressed,
                        icon: const Icon(Icons.backspace_outlined,
                            color: AppColors.deepBlue, size: 26),
                        constraints:
                            const BoxConstraints(minWidth: 60, minHeight: 60),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 50,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value.isNotEmpty
              ? AppColors.deepBlue
              : Colors.black.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          value,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue),
        ),
      ),
    );
  }

  Widget _buildKeypadButton(String value) {
    return InkWell(
      onTap: () => _onKeypadPressed(value),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        child: Text(
          value,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue),
        ),
      ),
    );
  }
}
