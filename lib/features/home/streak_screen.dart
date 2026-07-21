import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  bool _isCheckedInToday = false;
  int _currentStreak = 4;

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
                    "Check-in setiap hari untuk klaim bonus poin!",
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
                    children: [
                      _buildDayItem("Sen", true),
                      _buildDayItem("Sel", true),
                      _buildDayItem("Rab", true),
                      _buildDayItem("Kam", true),
                      _buildDayItem("Jum", _isCheckedInToday, isToday: true),
                      _buildDayItem("Sab", false),
                      _buildDayItem("Min", false),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Berhasil Check-In! +50 Poin 🎉"),
                            backgroundColor: Colors.green,
                          ),
                        );
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
                      : "Check-In Sekarang (+50 Poin)",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
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
