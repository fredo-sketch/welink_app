import 'package:flutter/material.dart';

class RewardScreen extends StatefulWidget {
  final int initialTab; // 0 = Tukar Poin, 1 = Voucher Saya

  const RewardScreen({super.key, this.initialTab = 0});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  late int _selectedTab;
  int _userPoints = 2350;

  final List<Map<String, dynamic>> _redeemItems = [
    {
      "id": "R01",
      "title": "Gratis 1 Kopi Susu Aren",
      "merchant": "Kopi Kita - Gunungpati",
      "points": 100,
      "imageUrl":
          "https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=200&auto=format&fit=crop",
    },
    {
      "id": "R02",
      "title": "Voucher Makan Rp 15.000",
      "merchant": "Bakso Berkah Utama",
      "points": 250,
      "imageUrl":
          "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?q=80&w=200&auto=format&fit=crop",
    },
    {
      "id": "R03",
      "title": "Diskon 20% Spa Treatment",
      "merchant": "Glow & Relax Spa",
      "points": 500,
      "imageUrl":
          "https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=200&auto=format&fit=crop",
    },
    {
      "id": "R04",
      "title": "Gratis Roti Tawar Gandum",
      "merchant": "Bake & Batter Bakery",
      "points": 150,
      "imageUrl":
          "https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop",
    },
  ];

  final List<Map<String, dynamic>> _myVouchers = [
    {
      "id": "V01",
      "title": "Diskon Rp 10.000 Kopi Kita",
      "merchant": "Kopi Kita - Gunungpati",
      "expiry": "Berlaku s/d 30 Jul 2026",
      "imageUrl":
          "https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=200&auto=format&fit=crop",
    },
    {
      "id": "V02",
      "title": "Gratis Es Teh Bakso Berkah",
      "merchant": "Bakso Berkah Utama",
      "expiry": "Berlaku s/d 05 Agu 2026",
      "imageUrl":
          "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?q=80&w=200&auto=format&fit=crop",
    },
    {
      "id": "V03",
      "title": "Potongan 20% Spa & Relax",
      "merchant": "Glow & Relax Spa",
      "expiry": "Berlaku s/d 12 Agu 2026",
      "imageUrl":
          "https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=200&auto=format&fit=crop",
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B192C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B192C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Reward & Member",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // TIER & BALANCE HEADER CARD
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
              border: Border.all(
                  color: const Color(0xFFFFD700).withOpacity(0.3), width: 1.5),
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

          // TOGGLE ACTIVE / INACTIVE BUTTONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3E62).withOpacity(0.5),
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
                              ? const Color(0xFFFFC107) // Gold jika aktif
                              : Colors.transparent, // Transparan/Inaktif
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Tukar Poin",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedTab == 0
                                ? Colors.black
                                : Colors.white70,
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
                              ? const Color(0xFFFFC107) // Gold jika aktif
                              : Colors.transparent, // Transparan/Inaktif
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Voucher Saya",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedTab == 1
                                ? Colors.black
                                : Colors.white70,
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

          // LIST KONTEN SAMA TAB SELECTED
          Expanded(
            child: _selectedTab == 0
                ? _buildTukarPoinTab()
                : _buildVoucherSayaTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildTukarPoinTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        const Text(
          "Rekomendasi Voucher Terdekat",
          style: TextStyle(
            color: Colors.white,
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
    final bool canRedeem = _userPoints >= (item["points"] as int);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3E62),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
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
                color: Colors.grey.shade700,
                child: const Icon(Icons.store, color: Colors.white),
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item["merchant"],
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "${item["points"]} Poin",
                    style: const TextStyle(
                      color: Color(0xFFFFC107),
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
            onPressed: canRedeem ? () => _handleRedeem(item) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC107),
              disabledBackgroundColor: Colors.grey.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              elevation: 0,
            ),
            child: Text(
              "Tukar",
              style: TextStyle(
                color: canRedeem ? Colors.black : Colors.white38,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleRedeem(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E3E62),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Konfirmasi Tukar Poin",
            style: TextStyle(color: Colors.white)),
        content: Text(
          "Tukar ${item['points']} Poin untuk '${item['title']}'?",
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107)),
            onPressed: () {
              setState(() {
                _userPoints -= (item["points"] as int);
                _myVouchers.insert(0, {
                  "id": "V${DateTime.now().millisecondsSinceEpoch}",
                  "title": item["title"],
                  "merchant": item["merchant"],
                  "expiry": "Berlaku s/d 31 Agu 2026",
                  "imageUrl": item["imageUrl"],
                });
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Berhasil menukar '${item['title']}'!"),
                  backgroundColor: Colors.green,
                ),
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

  Widget _buildVoucherSayaTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        Text(
          "Voucher Aktif Anda (${_myVouchers.length} Tersedia)",
          style: const TextStyle(
            color: Colors.white,
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
            color: Colors.black.withOpacity(0.15),
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
              voucher["imageUrl"],
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 52,
                height: 52,
                color: Colors.grey.shade200,
                child: const Icon(Icons.confirmation_number_rounded,
                    color: Color(0xFF0B192C)),
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
                    color: Colors.grey.shade700,
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text("Menampilkan kode QR untuk '${voucher['title']}'"),
                  backgroundColor: const Color(0xFF1E3E62),
                ),
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
