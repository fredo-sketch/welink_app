import 'dart:async';
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
  Timer? _countdownTimer;

  // DATA REWARD BERDASARKAN MERCHANT (POIN TERPISAH PER MERCHANT)
  final List<Map<String, dynamic>> _merchantRewards = [
    {
      "merchantId": "M01",
      "merchantName": "Kopi Kita - Gunungpati",
      "merchantLogo":
          "https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=200&auto=format&fit=crop",
      "userPoints": 350,
      "items": [
        {
          "id": "R01",
          "title": "Gratis 1 Kopi Susu Aren",
          "points": 100,
          "imageUrl":
              "https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=200&auto=format&fit=crop",
          "isRedeemed": false,
          "code": null,
          "expiresAt": null,
        },
        {
          "id": "R04",
          "title": "Diskon Rp 10.000 All Drink",
          "points": 200,
          "imageUrl":
              "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?q=80&w=200&auto=format&fit=crop",
          "isRedeemed": false,
          "code": null,
          "expiresAt": null,
        },
      ]
    },
    {
      "merchantId": "M02",
      "merchantName": "Bakso Berkah Utama",
      "merchantLogo":
          "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?q=80&w=200&auto=format&fit=crop",
      "userPoints": 150,
      "items": [
        {
          "id": "R02",
          "title": "Voucher Makan Rp 15.000",
          "points": 250,
          "imageUrl":
              "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?q=80&w=200&auto=format&fit=crop",
          "isRedeemed": false,
          "code": null,
          "expiresAt": null,
        },
        {
          "id": "R05",
          "title": "Gratis Es Teh Manis",
          "points": 50,
          "imageUrl":
              "https://images.unsplash.com/photo-1556679343-c7306c1976bc?q=80&w=200&auto=format&fit=crop",
          "isRedeemed": false,
          "code": null,
          "expiresAt": null,
        },
      ]
    },
    {
      "merchantId": "M03",
      "merchantName": "Glow & Relax Spa",
      "merchantLogo":
          "https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=200&auto=format&fit=crop",
      "userPoints": 600,
      "items": [
        {
          "id": "R03",
          "title": "Diskon 20% Spa Treatment",
          "points": 500,
          "imageUrl":
              "https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=200&auto=format&fit=crop",
          "isRedeemed": false,
          "code": null,
          "expiresAt": null,
        },
      ]
    },
  ];

  // DATA VOUCHER SAYA
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
  ];

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  int get _totalCombinedPoints {
    return _merchantRewards.fold(
        0, (sum, item) => sum + (item["userPoints"] as int));
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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Menghilangkan ikon back otomatis
        title: const Text(
          "Reward & Member",
          style: TextStyle(
            color: Color(0xFF0B192C),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // TOTAL COMBINED POINTS HEADER
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
                      "Total Poin Terkumpul",
                      style: TextStyle(
                        color: Color(0xFFFFD700),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "$_totalCombinedPoints Poin",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Tersebar di ${_merchantRewards.length} Merchant",
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
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
                    Icons.store_rounded,
                    color: Color(0xFFFFD700),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // TOGGLE TAB
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
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
                                : Colors.grey.shade600,
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

          Expanded(
            child: _selectedTab == 0
                ? _buildTukarPoinTab()
                : _buildVoucherSayaTab(),
          ),
        ],
      ),
    );
  }

  // ================= TAB TUKAR POIN (DILAYOUT PER-MERCHANT) =================
  Widget _buildTukarPoinTab() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: _merchantRewards.length,
      itemBuilder: (context, index) {
        final merchant = _merchantRewards[index];
        final List items = merchant["items"];

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER MERCHANT & SALDO POIN SPESIFIK
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(18)),
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        merchant["merchantLogo"],
                        width: 38,
                        height: 38,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            merchant["merchantName"],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B192C),
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            "Member Loyalty",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFFFFC107).withOpacity(0.5)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.stars_rounded,
                              size: 14, color: Color(0xFFD49A00)),
                          const SizedBox(width: 4),
                          Text(
                            "${merchant["userPoints"]} Poin",
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD49A00),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // DAFTAR ITEM REWARD MILIK MERCHANT TERSEBUT
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: items.map<Widget>((item) {
                    return _buildRedeemItemCard(merchant, item);
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRedeemItemCard(
      Map<String, dynamic> merchant, Map<String, dynamic> item) {
    final bool isRedeemed = item["isRedeemed"] ?? false;
    final int merchantPoints = merchant["userPoints"];
    final bool canRedeem = merchantPoints >= (item["points"] as int);

    Duration remaining = Duration.zero;
    if (isRedeemed && item["expiresAt"] != null) {
      remaining = (item["expiresAt"] as DateTime).difference(DateTime.now());
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRedeemed ? const Color(0xFFFFC107) : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item["imageUrl"],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["title"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF0B192C),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${item["points"]} Poin",
                      style: const TextStyle(
                        color: Color(0xFFD49A00),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: (!isRedeemed && canRedeem)
                    ? () => _handleRedeem(merchant, item)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRedeemed
                      ? Colors.grey.shade300
                      : const Color(0xFFFFC107),
                  disabledBackgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 0,
                ),
                child: Text(
                  isRedeemed
                      ? "Ditukar"
                      : (canRedeem ? "Tukar" : "Poin Kurang"),
                  style: TextStyle(
                    color: isRedeemed ? Colors.grey.shade500 : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),

          // DITAMPILKAN JIKA ITEM SUDAH DITUKAR
          if (isRedeemed) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: const Color(0xFFFFC107).withOpacity(0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "KODE KASIR",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SelectableText(
                        item["code"] ?? "",
                        style: const TextStyle(
                          color: Color(0xFF0B192C),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.timer_rounded,
                          color: Colors.redAccent, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        _formatDuration(remaining),
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }

  void _handleRedeem(Map<String, dynamic> merchant, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Konfirmasi Tukar Poin",
            style: TextStyle(
                color: Color(0xFF0B192C), fontWeight: FontWeight.bold)),
        content: Text(
          "Tukar ${item['points']} Poin ${merchant['merchantName']} untuk '${item['title']}'?",
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
              final String uniqueCode =
                  "WLK-${(100000 + (item['title'].hashCode % 899999)).abs()}";
              final DateTime expiresAt =
                  DateTime.now().add(const Duration(hours: 24));

              setState(() {
                merchant["userPoints"] =
                    (merchant["userPoints"] as int) - (item["points"] as int);
                item["isRedeemed"] = true;
                item["code"] = uniqueCode;
                item["expiresAt"] = expiresAt;
              });

              Navigator.pop(context);
            },
            child: const Text("Ya, Tukar",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
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
            color: Color(0xFF0B192C),
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
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(color: Colors.grey.shade200),
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
                    color: Colors.grey.shade600,
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
          OutlinedButton(
            onPressed: () {},
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
