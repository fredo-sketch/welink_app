import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
// Import screen QR dari folder features/scan
import '../scan/customer_qr_screen.dart';

class MerchantDetailScreen extends StatelessWidget {
  final Map<String, dynamic> merchantData;

  const MerchantDetailScreen({super.key, required this.merchantData});

  @override
  Widget build(BuildContext context) {
    final String name = merchantData["name"] ?? "Nama Merchant";
    final String imageUrl = merchantData["imageUrl"] ?? "";
    final String description = merchantData["description"] ?? "";
    final String badgeType = merchantData["badgeType"] ?? "guest";
    final String statusInfo = merchantData["statusInfo"] ?? "";
    final String points = merchantData["points"] ?? "";
    final List<dynamic> tags = merchantData["tags"] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.deepBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          name,
          style: const TextStyle(
              color: AppColors.deepBlue, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Banner
            Container(
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(color: Color(0xffeef2f7)),
              child: imageUrl.isNotEmpty
                  ? Image.network(imageUrl, fit: BoxFit.cover)
                  : const Icon(Icons.storefront,
                      size: 64, color: AppColors.deepBlue),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul & Tag
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: tags.map((tag) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xffeef4fa),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tag.toString(),
                          style: const TextStyle(
                            color: Color(0xff4a709c),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Deskripsi
                  const Text(
                    "Tentang Merchant",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                        height: 1.5),
                  ),
                  const SizedBox(height: 28),

                  // Kartu Status Pengguna
                  const Text(
                    "Status Member Anda",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue),
                  ),
                  const SizedBox(height: 12),
                  _buildStatusCard(badgeType, statusInfo, points),
                ],
              ),
            ),
          ],
        ),
      ),
      // Tombol Aksi di Bawah
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Aksi Bayar/Scan
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomerQrScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepBlue,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 0,
          ),
          child: const Text(
            "Scan QR & Bayar di Sini",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // Desain Kartu Status yang menyesuaikan dengan Tipe Member
  Widget _buildStatusCard(String type, String info, String points) {
    Color cardColor;
    Color iconColor;
    IconData statusIcon;

    if (type == "member") {
      cardColor = AppColors.accentGold.withOpacity(0.2);
      iconColor = AppColors.accentGold;
      statusIcon = Icons.workspace_premium;
    } else if (type == "progress") {
      cardColor = const Color(0xffdbeafe);
      iconColor = const Color(0xff1e40af);
      statusIcon = Icons.trending_up;
    } else {
      cardColor = const Color(0xfff1f5f9);
      iconColor = const Color(0xff64748b);
      statusIcon = Icons.person_add_alt_1;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(statusIcon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  points,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: iconColor == AppColors.accentGold
                          ? AppColors.deepBlue
                          : iconColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            info,
            style:
                TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}
