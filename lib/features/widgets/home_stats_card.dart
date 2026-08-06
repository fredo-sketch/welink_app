import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../member_streak/active_membership_screen.dart';
import '../member_streak/streak_screen.dart';
import '../reward/reward_screen.dart';

class HomeStatsCard extends StatelessWidget {
  const HomeStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.stars_rounded,
                    iconColor: Colors.amber.shade600,
                    value: "1,100",
                    label: "POIN ANDA",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const RewardScreen(initialTab: 0),
                        ),
                      );
                    },
                  ),
                ),
                Container(width: 1, color: Colors.black.withOpacity(0.05)),
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.confirmation_number_rounded,
                    iconColor: Colors.blue.shade600,
                    value: "5",
                    label: "MEMBERSHIP AKTIF",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ActiveMembershipScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.black.withOpacity(0.05), height: 1),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.local_activity_rounded,
                    iconColor: Colors.indigo.shade600,
                    value: "2",
                    label: "VOUCHER TERSEDIA",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const RewardScreen(initialTab: 1),
                        ),
                      );
                    },
                  ),
                ),
                Container(width: 1, color: Colors.black.withOpacity(0.05)),
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.local_fire_department_rounded,
                    iconColor: Colors.red.shade600,
                    value: "6",
                    label: "HARI",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StreakScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepBlue,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
