import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedCategoryIndex = 0;

  final List<String> _categories = ["Semua", "Makanan", "Minuman", "Cemilan"];

  // URL diganti ke Picsum ID yang mendukung CORS penuh di Flutter Web
  final List<Map<String, dynamic>> _merchants = [
    {
      "name": "Kopi Kita",
      "badge": "MEMBER",
      "badgeType": "member",
      "distance": "350 m dari lokasi Anda",
      "tags": ["Coffee", "WiFi"],
      "imageUrl":
          "https://picsum.photos/id/1060/300/300", // Foto cangkir kopi & cafe
    },
    {
      "name": "Bakso Berkah",
      "badge": "Progress 1/3",
      "badgeType": "progress",
      "distance": "650 m dari lokasi Anda",
      "tags": ["Meatballs", "Local Fav"],
      "imageUrl":
          "https://picsum.photos/id/292/300/300", // Foto bahan makanan/dapur
    },
    {
      "name": "Warung Nasi Ibu",
      "badge": "Guest",
      "badgeType": "guest",
      "distance": "800 m dari lokasi Anda",
      "tags": ["Indonesian", "Murah"],
      "imageUrl":
          "https://picsum.photos/id/493/300/300", // Foto makanan di meja makan
    },
    {
      "name": "Toko Kelontong Jaya",
      "badge": "Guest",
      "badgeType": "guest",
      "distance": "1.2 km dari lokasi Anda",
      "tags": ["Groceries", "24 Jam"],
      "imageUrl":
          "https://picsum.photos/id/1070/300/300", // Foto suasana market/toko
    },
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final safeTopPadding = topPadding > 0 ? topPadding + 12 : 24.0;

    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),
      body: Column(
        children: [
          // ==========================================
          // HEADER SECTION
          // ==========================================
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: safeTopPadding, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: AppColors.deepBlue, size: 18),
                      const SizedBox(width: 6),
                      const Text(
                        "Gunungpati, Semarang",
                        style: TextStyle(
                          color: AppColors.deepBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down_rounded,
                          color: AppColors.deepBlue.withOpacity(0.7), size: 18),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xfff0f4f8),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Cari merchant atau kategori makanan...",
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.3), fontSize: 13),
                        prefixIcon: Icon(Icons.search,
                            color: Colors.black.withOpacity(0.4), size: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: List.generate(_categories.length, (index) {
                      final isSelected = _selectedCategoryIndex == index;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedCategoryIndex = index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.deepBlue
                                : const Color(0xffeef2f7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _categories[index],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.deepBlue.withOpacity(0.8),
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          // Filter Bar
          Container(
            color: const Color(0xfff8fafc),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                _buildFilterTag("Terdekat", hasDropdown: true),
                const SizedBox(width: 8),
                _buildFilterTag("Ada Promo"),
                const SizedBox(width: 8),
                _buildFilterTag("Sudah Member"),
                const Spacer(),
                Icon(Icons.tune_rounded,
                    color: Colors.black.withOpacity(0.6), size: 18),
              ],
            ),
          ),

          // ==========================================
          // MERCHANT LIST SECTION
          // ==========================================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              itemCount: _merchants.length,
              itemBuilder: (context, index) {
                final merchant = _merchants[index];

                final String name = merchant["name"]?.toString() ?? "";
                final String distance = merchant["distance"]?.toString() ?? "";
                final String badge = merchant["badge"]?.toString() ?? "";
                final String badgeType =
                    merchant["badgeType"]?.toString() ?? "";
                final String imageUrl = merchant["imageUrl"]?.toString() ?? "";
                final List<dynamic> tags =
                    merchant["tags"] is List ? merchant["tags"] : [];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // KIRI: SEKARANG MEMAKAI NETWORK IMAGE BER-CORS OPEN
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: 85,
                          height: 85,
                          color: const Color(0xffeef2f7),
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.deepBlue,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.storefront_rounded,
                                          color: AppColors.deepBlue, size: 32),
                                )
                              : const Icon(Icons.storefront_rounded,
                                  color: AppColors.deepBlue, size: 32),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // KANAN: Detail Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                      color: AppColors.deepBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                _buildBadge(badge, badgeType),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.navigation_rounded,
                                    color: Colors.black.withOpacity(0.3),
                                    size: 12),
                                const SizedBox(width: 4),
                                Text(
                                  distance,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: tags.map((tag) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffeef4fa),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    tag.toString(),
                                    style: const TextStyle(
                                      color: Color(0xff4a709c),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFilterTag(String text, {bool hasDropdown = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          if (hasDropdown) ...[
            const SizedBox(width: 2),
            Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.black.withOpacity(0.5), size: 14),
          ]
        ],
      ),
    );
  }

  Widget _buildBadge(String text, String type) {
    Color bgColor = const Color(0xffe2e8f0);
    Color textColor = const Color(0xff64748b);

    if (type == "member") {
      bgColor = AppColors.accentGold;
      textColor = AppColors.deepBlue;
    } else if (type == "progress") {
      bgColor = const Color(0xffdbeafe);
      textColor = const Color(0xff1e40af);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
