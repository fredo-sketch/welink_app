import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class RewardScreen extends StatefulWidget {
  final int initialTab;

  const RewardScreen({super.key, this.initialTab = 0});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  late int _selectedTab;
  int _userPoints = 2350;
  Timer? _countdownTimer;

  // 1. DATA ITEM TUKAR POIN
  final List<Map<String, dynamic>> _redeemItems = [
    {
      "id": "R01",
      "title": "Gratis 1 Kopi Susu Aren",
      "merchant": "Kopi Kita - Gunungpati",
      "points": 100,
      "imageUrl":
          "https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=200&auto=format&fit=crop",
      "isRedeemed": false,
      "code": null,
      "expiresAt": null,
    },
    {
      "id": "R02",
      "title": "Voucher Makan Rp 15.000",
      "merchant": "Bakso Berkah Utama",
      "points": 250,
      "imageUrl":
          "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?q=80&w=200&auto=format&fit=crop",
      "isRedeemed": false,
      "code": null,
      "expiresAt": null,
    },
    {
      "id": "R03",
      "title": "Diskon 20% Spa Treatment",
      "merchant": "Glow & Relax Spa",
      "points": 500,
      "imageUrl":
          "https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=200&auto=format&fit=crop",
      "isRedeemed": false,
      "code": null,
      "expiresAt": null,
    },
    {
      "id": "R04",
      "title": "Gratis Roti Tawar Gandum",
      "merchant": "Bake & Batter Bakery",
      "points": 150,
      "imageUrl":
          "https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop",
      "isRedeemed": false,
      "code": null,
      "expiresAt": null,
    },
  ];

  // 2. DATA VOUCHER SAYA
  final List<Map<String, dynamic>> _myVouchers = [
    {
      "id": "V01",
      "title": "Diskon Rp 10.000 Kopi Kita",
      "merchant": "Kopi Kita - Gunungpati",
      "code": "WLK-849201",
      "expiry": "Berlaku s/d 30 Jul 2026",
      "imageUrl":
          "https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=200&auto=format&fit=crop",
    },
    {
      "id": "V02",
      "title": "Gratis Es Teh Bakso Berkah",
      "merchant": "Bakso Berkah Utama",
      "code": "WLK-392104",
      "expiry": "Berlaku s/d 05 Agu 2026",
      "imageUrl":
          "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?q=80&w=200&auto=format&fit=crop",
    },
    {
      "id": "V03",
      "title": "Potongan 20% Spa & Relax",
      "merchant": "Glow & Relax Spa",
      "code": "WLK-552190",
      "expiry": "Berlaku s/d 12 Agu 2026",
      "imageUrl":
          "https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=200&auto=format&fit=crop",
    },
    {
      "id": "V04",
      "title": "Gratis Roti Tawar Gandum",
      "merchant": "Bake & Batter Bakery",
      "code": "WLK-110293",
      "expiry": "Berlaku s/d 15 Agu 2026",
      "imageUrl":
          "https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop",
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  String _generateUniqueCode() {
    final random = Random();
    final number = 100000 + random.nextInt(899999);
    return "WLK-$number";
  }

  String _formatDuration(Duration duration) {
    if (duration.isNegative) return "Expired";
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Ubah ke terang
      appBar: AppBar(
        backgroundColor: Colors.white, // Ubah ke terang
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF0B192C), size: 20), // Ikon jadi gelap
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Reward & Member",
          style: TextStyle(
            color: Color(0xFF0B192C), // Teks judul jadi gelap
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // TIER & BALANCE HEADER CARD (Tetap dipertahankan gelap agar kontras)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3E62), Color(0xFF0B192C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gold Tier",
                      style: TextStyle(
                        color: Color(0xFFFFD700),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "$_userPoints Poin",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.stars_rounded,
                    color: Color(0xFFFFD700),
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // TOGGLE BUTTONS TAB (Versi Terang)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200, // Background tab terang
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 0
                              ? const Color(0xFFFFC107)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Tukar Poin",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedTab == 0
                                ? Colors.black
                                : Colors
                                    .grey.shade600, // Teks tidak aktif abu-abu
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 1
                              ? const Color(0xFFFFC107)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Voucher Saya",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedTab == 1
                                ? Colors.black
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // SWITCH TAB CONTENT
          Expanded(
            child: _selectedTab == 0
                ? _buildTukarPoinTab()
                : _buildVoucherSayaTab(),
          ),
        ],
      ),
    );
  }

  // ================= TAB TUKAR POIN =================
  Widget _buildTukarPoinTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        const Text(
          "Rekomendasi Voucher Terdekat",
          style: TextStyle(
            color: Color(0xFF0B192C), // Teks utama jadi gelap
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ..._redeemItems.map((item) => _buildRedeemCard(item)).toList(),
      ],
    );
  }

  Widget _buildRedeemCard(Map<String, dynamic> item) {
    final bool isRedeemed = item["isRedeemed"] ?? false;
    final bool canRedeem = _userPoints >= (item["points"] as int);

    Duration remaining = Duration.zero;
    if (isRedeemed && item["expiresAt"] != null) {
      remaining = (item["expiresAt"] as DateTime).difference(DateTime.now());
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white, // Kartu warna putih
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isRedeemed ? const Color(0xFFFFC107) : Colors.grey.shade200,
          width: isRedeemed ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // Bayangan tipis
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item["imageUrl"],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.store, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["title"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF0B192C), // Judul gelap
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item["merchant"],
                      style: TextStyle(
                        color: Colors.grey.shade600, // Subtitle abu-abu
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "${item["points"]} Poin",
                        style: const TextStyle(
                          color: Color(0xFFD49A00), // Poin warna emas gelap
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: (!isRedeemed && canRedeem)
                    ? () => _handleRedeem(item)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRedeemed
                      ? Colors.grey
                          .shade300 // Warna dinonaktifkan jadi abu-abu muda
                      : const Color(0xFFFFC107),
                  disabledBackgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  elevation: 0,
                ),
                child: Text(
                  isRedeemed ? "Ditukar" : "Tukar",
                  style: TextStyle(
                    color: isRedeemed ? Colors.grey.shade500 : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          // TAMPILAN TAMBAHAN (DI BAWAH CARD ITEM YANG DITUKAR)
          if (isRedeemed) ...[
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade200, height: 1), // Divider terang
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50, // Area unik terang
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFFFC107).withOpacity(0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "KODE UNIK VOUCHER",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 9,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SelectableText(
                        item["code"] ?? "",
                        style: const TextStyle(
                          color: Color(0xFF0B192C), // Teks kode gelap
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: Colors.redAccent.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.timer_rounded,
                            color: Colors.redAccent, size: 14),
                        const SizedBox(width: 5),
                        Text(
                          _formatDuration(remaining),
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _handleRedeem(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white, // Dialog terang
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Konfirmasi Tukar Poin",
            style: TextStyle(
                color: Color(0xFF0B192C), fontWeight: FontWeight.bold)),
        content: Text(
          "Tukar ${item['points']} Poin untuk '${item['title']}'?",
          style: TextStyle(color: Colors.grey.shade700),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal", style: TextStyle(color: Colors.grey.shade600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107)),
            onPressed: () {
              final String uniqueCode = _generateUniqueCode();
              final DateTime expiresAt =
                  DateTime.now().add(const Duration(hours: 24));

              setState(() {
                _userPoints -= (item["points"] as int);
                item["isRedeemed"] = true;
                item["code"] = uniqueCode;
                item["expiresAt"] = expiresAt;
              });

              Navigator.pop(context);

              _showUniqueCodeModal(
                title: item["title"],
                merchant: item["merchant"],
                code: uniqueCode,
              );
            },
            child: const Text("Ya, Tukar",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showUniqueCodeModal({
    required String title,
    required String merchant,
    required String code,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white, // Modal terang
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 36),
              ),
              const SizedBox(height: 14),
              const Text(
                "Penukaran Berhasil!",
                style: TextStyle(
                  color: Color(0xFF0B192C), // Teks sukses gelap
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFD49A00),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Text(
                merchant,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50, // Area unik terang
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: const Color(0xFFFFC107).withOpacity(0.8),
                      width: 1.5),
                ),
                child: Column(
                  children: [
                    Text(
                      "KODE VOUCHER KASIR",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 10,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      code,
                      style: const TextStyle(
                        color: Color(0xFF0B192C), // Kode voucher gelap
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Tunjukkan kode ini kepada kasir merchant",
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timer_rounded,
                        color: Colors.redAccent, size: 16),
                    SizedBox(width: 6),
                    Text(
                      "Masa Berlaku: 24 Jam",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Okay",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= TAB VOUCHER SAYA =================
  Widget _buildVoucherSayaTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        Text(
          "Voucher Aktif Anda (${_myVouchers.length} Tersedia)",
          style: const TextStyle(
            color: Color(0xFF0B192C), // Judul gelap
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ..._myVouchers.map((voucher) => _buildVoucherCard(voucher)).toList(),
      ],
    );
  }

  Widget _buildVoucherCard(Map<String, dynamic> voucher) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // Bayangan ditipiskan
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(color: Colors.grey.shade200), // Tambah border tipis
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              voucher["imageUrl"],
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 52,
                height: 52,
                color: Colors.grey.shade200,
                child: const Icon(Icons.confirmation_number_rounded,
                    color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voucher["title"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF0B192C),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  voucher["merchant"],
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600, // Warna lebih soft
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  voucher["expiry"],
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: () {
              _showUniqueCodeModal(
                title: voucher["title"],
                merchant: voucher["merchant"],
                code: voucher["code"],
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF0B192C), width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text(
              "Pakai",
              style: TextStyle(
                color: Color(0xFF0B192C),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
