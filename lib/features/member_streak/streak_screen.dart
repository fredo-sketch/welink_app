import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/colors.dart';

class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  bool _isCheckedInToday = false;
  int _currentStreak = 6;
  bool _isNewCycle = false;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ANIMASI API LOTTIE
              Lottie.asset(
                'assets/animations/fire.json',
                width: 270,
                height: 270,
                repeat: true,
              ),
              const SizedBox(height: 8),
              Text(
                "Streak $_currentStreak Hari",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // BADGE PROGRES LEVEL
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF512F).withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.workspace_premium_rounded,
                        color: Color(0xFFFF512F), size: 22),
                    SizedBox(width: 8),
                    Text(
                      "Progres Level Bertambah!",
                      style: TextStyle(
                        color: Color(0xFFFF512F),
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              // TOMBOL KLAIM
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _isNewCycle = true;
                      _isCheckedInToday = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepBlue,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Klaim & Lanjutkan",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.deepBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Daily Streak",
          style: TextStyle(
              color: AppColors.deepBlue,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF512F), Color(0xFFDD2476)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF512F).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.local_fire_department_rounded,
                      color: Colors.white, size: 70),
                  const SizedBox(height: 8),
                  Text(
                    "$_currentStreak Hari Berturut-turut!",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Check-in setiap hari untuk menaikkan Level Member-mu!",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Progres Minggu Ini",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.deepBlue),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _isNewCycle
                        ? [
                            _buildDayItem("Sen", _isCheckedInToday,
                                isToday: true),
                            _buildDayItem("Sel", false),
                            _buildDayItem("Rab", false),
                            _buildDayItem("Kam", false),
                            _buildDayItem("Jum", false),
                            _buildDayItem("Sab", false),
                            _buildDayItem("Min", false),
                          ]
                        : [
                            _buildDayItem("Sen", true),
                            _buildDayItem("Sel", true),
                            _buildDayItem("Rab", true),
                            _buildDayItem("Kam", true),
                            _buildDayItem("Jum", true),
                            _buildDayItem("Sab", true),
                            _buildDayItem("Min", _isCheckedInToday,
                                isToday: true),
                          ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isCheckedInToday
                    ? null
                    : () {
                        setState(() {
                          _isCheckedInToday = true;
                          _currentStreak += 1;
                        });
                        _showSuccessDialog();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deepBlue,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  _isCheckedInToday
                      ? "Sudah Check-In Hari Ini"
                      : "Check-In Sekarang",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isCheckedInToday
                          ? Colors.grey.shade600
                          : Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDayItem(String day, bool active, {bool isToday = false}) {
    return Column(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: active
                ? const Color(0xFFFF512F)
                : (isToday ? const Color(0xFFFEF3C7) : const Color(0xFFF1F5F9)),
            shape: BoxShape.circle,
            border: isToday
                ? Border.all(color: const Color(0xFFFF512F), width: 2)
                : null,
          ),
          child: Icon(
            active ? Icons.check_rounded : Icons.local_fire_department_rounded,
            color: active
                ? Colors.white
                : (isToday ? const Color(0xFFFF512F) : Colors.grey.shade400),
            size: 20,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          day,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: active ? AppColors.deepBlue : Colors.grey),
        )
      ],
    );
  }
}
