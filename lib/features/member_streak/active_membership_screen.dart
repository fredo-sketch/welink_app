import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class ActiveMembershipScreen extends StatelessWidget {
  const ActiveMembershipScreen({super.key});

  final List<Map<String, dynamic>> _memberships = const [
    {
      "name": "Kopi Kita Gunungpati",
      "tier": "VIP Member",
      "points": "450 Poin",
      "joined": "Member sejak Mei 2025",
      "imageUrl":
          "https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=200&auto=format&fit=crop",
    },
    {
      "name": "Bakso Berkah Utama",
      "tier": "Gold Tier",
      "points": "210 Poin",
      "joined": "Member sejak Jan 2026",
      "imageUrl":
          "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?q=80&w=200&auto=format&fit=crop",
    },
    {
      "name": "Glow & Relax Spa",
      "tier": "Silver Member",
      "points": "120 Poin",
      "joined": "Member sejak Mar 2026",
      "imageUrl":
          "https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=200&auto=format&fit=crop",
    },
    {
      "name": "Bake & Batter Bakery",
      "tier": "Basic Member",
      "points": "80 Poin",
      "joined": "Member sejak Jun 2026",
      "imageUrl":
          "https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop",
    },
    {
      "name": "Style Fashion Store",
      "tier": "Gold Tier",
      "points": "390 Poin",
      "joined": "Member sejak Feb 2026",
      "imageUrl":
          "https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=200&auto=format&fit=crop",
    },
  ];

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
          "Membership Saya (5)",
          style: TextStyle(
              color: AppColors.deepBlue,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _memberships.length,
        itemBuilder: (context, index) {
          final item = _memberships[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item["imageUrl"],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.store, color: AppColors.deepBlue),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["name"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.deepBlue),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item["joined"],
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade500),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item["tier"],
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB45309)),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item["points"],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF16A34A),
                          fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        size: 14, color: Colors.grey),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
