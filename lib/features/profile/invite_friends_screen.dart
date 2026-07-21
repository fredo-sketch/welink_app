import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  // Konstanta Warna Utama (Lokal agar tidak error import)
  static const Color primaryNavy = Color(0xFF0B192C);
  static const Color accentGold = Color(0xFFFFD700);
  static const Color bgLight = Color(0xFFF8FAFC);

  final String _referralCode = "WELINK2026";

  // Mock list teman yang diundang
  final List<Map<String, dynamic>> _invitedFriends = [
    {
      "name": "Budi Santoso",
      "date": "18 Jul 2026",
      "status": "Reward Diklaim",
      "amount": "+ 500 poin",
      "isSuccess": true,
      "avatar":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80",
    },
    {
      "name": "Siti Rahma",
      "date": "15 Jul 2026",
      "status": "Reward Diklaim",
      "amount": "+ 500 poin",
      "isSuccess": true,
      "avatar":
          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80",
    },
    {
      "name": "Rian Ardianto",
      "date": "10 Jul 2026",
      "status": "Belum Transaksi",
      "amount": "Menunggu",
      "isSuccess": false,
      "avatar":
          "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?auto=format&fit=crop&w=150&q=80",
    },
  ];

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text("Kode referral berhasil disalin!"),
          ],
        ),
        backgroundColor: primaryNavy,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryNavy,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Undang Teman",
          style: TextStyle(
            color: primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. HERO REFERRAL CARD
            // ==========================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryNavy, Color(0xFF1E3E62)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: accentGold.withOpacity(0.4),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryNavy.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: accentGold.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/logo_welink.png', // <-- SESUAIKAN DENGAN PATH LOGO KAMU
                      width: 36,
                      height: 36,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback otomatis jika path gambar salah / belum terdaftar
                        return const Icon(
                          Icons.link_rounded,
                          color: accentGold,
                          size: 36,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Undang Teman, Dapatkan 500 poin",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Bagikan kode unikmu ke teman. Dapatkan saldo reward setelah mereka menyelesaikan transaksi pertama!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // BOX KODE REFERRAL
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: accentGold.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "KODE REFERRAL KAMU",
                              style: TextStyle(
                                fontSize: 9,
                                color: accentGold,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _referralCode,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: _copyToClipboard,
                          icon: const Icon(Icons.copy_rounded, size: 14),
                          label: const Text("Salin"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentGold,
                            foregroundColor: primaryNavy,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==========================================
            // 2. STATS SUMMARY
            // ==========================================
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Teman Bergabung",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "3 Teman",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryNavy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Reward",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "1.000 poin",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ==========================================
            // 3. CARA KERJA (STEPS)
            // ==========================================
            const Text(
              "Cara Kerja",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryNavy,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildStepRow(
                    step: "1",
                    title: "Bagikan Kode Referral",
                    subtitle: "Kirimkan kode unik ke teman atau keluarga.",
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                  ),
                  _buildStepRow(
                    step: "2",
                    title: "Teman Mendaftar",
                    subtitle:
                        "Teman mendownload aplikasi dan memasukkan kodemu.",
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                  ),
                  _buildStepRow(
                    step: "3",
                    title: "Klaim Reward",
                    subtitle: "Dapatkan poin reward 500 secara otomatis.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ==========================================
            // 4. DAFTAR TEMAN DIUNDANG
            // ==========================================
            const Text(
              "Teman yang Kamu Undang",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryNavy,
              ),
            ),
            const SizedBox(height: 12),

            Column(
              children: _invitedFriends.map((friend) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(friend["avatar"]),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              friend["name"],
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: primaryNavy,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              friend["date"],
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            friend["amount"],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: friend["isSuccess"]
                                  ? const Color(0xFF16A34A)
                                  : Colors.orange.shade800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            friend["status"],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),

      // Bottom Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -4),
            )
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: _copyToClipboard,
            icon: const Icon(Icons.share_rounded, size: 18),
            label: const Text(
              "Bagikan Link Referral",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryNavy,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepRow(
      {required String step, required String title, required String subtitle}) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: primaryNavy,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: primaryNavy,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
