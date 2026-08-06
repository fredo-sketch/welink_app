import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class BirthdayTreatScreen extends StatefulWidget {
  const BirthdayTreatScreen({super.key});

  @override
  State<BirthdayTreatScreen> createState() => _BirthdayTreatScreenState();
}

class _BirthdayTreatScreenState extends State<BirthdayTreatScreen> {
  // Mock data tanggal lahir
  String birthDate = "15 Agustus";

  // Filter Kategori Aktif
  String _selectedCategory = "Semua";

  // Data 7 Birthday Treats dengan FOTO REAL (Unsplash URLs)
  final List<Map<String, dynamic>> _treatList = [
    {
      "id": "1",
      "merchant": "Kopi Kita",
      "location": "Gunungpati (1.2 km)",
      "title": "FREE Birthday Iced Americano",
      "subtitle":
          "Klaim kopi favoritmu tanpa minimum pembelian khusus di bulan ultah.",
      "category": "Food & Beverage",
      "tag": "NO MIN. SPEND",
      "expiry": "Berlaku s/d Akhir Bulan",
      "imageUrl":
          "https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=400&q=80",
      "isClaimed": false,
    },
    {
      "id": "2",
      "merchant": "Gourmet Haven",
      "location": "Semarang Kota (2.5 km)",
      "title": "Diskon 30% Birthday Dinner",
      "subtitle":
          "Nikmati santap malam istimewa bersama keluarga/teman diskon 30%.",
      "category": "Food & Beverage",
      "tag": "DISCOUNT VOUCHER",
      "expiry": "Berlaku Minggu Ultah",
      "imageUrl":
          "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=400&q=80",
      "isClaimed": false,
    },
    {
      "id": "3",
      "merchant": "Bake & Batter Bakery",
      "location": "Sekaran (0.8 km)",
      "title": "Gratis 1 Slice Birthday Cake",
      "subtitle": "Ambil slice kue ultah varian apa saja langsung di outlet.",
      "category": "Food & Beverage",
      "tag": "FREE DESSERT",
      "expiry": "Berlaku s/d Akhir Bulan",
      "imageUrl":
          "https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=400&q=80",
      "isClaimed": true,
    },
    {
      "id": "4",
      "merchant": "Glow & Relax Spa",
      "location": "Sampangan (4.0 km)",
      "title": "Voucher Ultah Rp 100.000",
      "subtitle":
          "Potongan langsung Rp 100rb untuk paket Body Massage & Treatment.",
      "category": "Beauty & Spa",
      "tag": "VIP TREAT",
      "expiry": "Berlaku s/d Akhir Bulan",
      "imageUrl":
          "https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=400&q=80",
      "isClaimed": false,
    },
    {
      "id": "5",
      "merchant": "Style Fashion Store",
      "location": "Simpang Lima (3.8 km)",
      "title": "Voucher Belanja Rp 50.000",
      "subtitle":
          "Diskon belanja pakaian new arrival dengan min. transaksi 150rb.",
      "category": "Shopping",
      "tag": "MIN. SPEND 150K",
      "expiry": "Berlaku s/d Akhir Bulan",
      "imageUrl":
          "https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=400&q=80",
      "isClaimed": false,
    },
    {
      "id": "6",
      "merchant": "Cinema XXI",
      "location": "DP Mall Semarang (5.0 km)",
      "title": "Gratis Popcorn Large + Drink",
      "subtitle": "Tunjukkan e-voucher ini saat beli tiket bioskop apapun.",
      "category": "Entertainment",
      "tag": "MOVIE TREAT",
      "expiry": "Berlaku Bulan Ultah",
      "imageUrl":
          "https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?auto=format&fit=crop&w=400&q=80",
      "isClaimed": false,
    },
    {
      "id": "7",
      "merchant": "Trans Studio Mini",
      "location": "Jatingaleh (3.1 km)",
      "title": "Gratis 10 Bonus Game Tokens",
      "subtitle": "Tambahan 10 koin main gratis untuk merayakan ulang tahunmu.",
      "category": "Entertainment",
      "tag": "SPECIAL GAME",
      "expiry": "Berlaku s/d Akhir Bulan",
      "imageUrl":
          "https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=400&q=80",
      "isClaimed": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTreats = _selectedCategory == "Semua"
        ? _treatList
        : _treatList
            .where((item) => item["category"] == _selectedCategory)
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.deepBlue,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Birthday Treat",
          style: TextStyle(
            color: AppColors.deepBlue,
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
            // 1. PROFESSIONAL HERO BANNER (DENGAN LOGO & VIRTUAL GRAPHIC)
            // ==========================================
            _buildProfessionalBanner(),

            const SizedBox(height: 20),

            // ==========================================
            // 2. KARTU INFORMASI TANGGAL LAHIR
            // ==========================================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.deepBlue.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.deepBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tanggal Lahir Kamu",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          birthDate,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.deepBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Ubah",
                      style: TextStyle(
                        color: AppColors.deepBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ==========================================
            // 3. FILTER KATEGORI (HORIZONTAL SCROLL)
            // ==========================================
            _buildCategoryFilter(),

            const SizedBox(height: 16),

            // ==========================================
            // 4. LIST 7 VOUCHER DENGAN FOTO REAL
            // ==========================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Voucher Ulang Tahunmu",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepBlue,
                  ),
                ),
                Text(
                  "${filteredTreats.length} Promo",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            filteredTreats.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child: Text(
                        "Tidak ada promo untuk kategori ini.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : Column(
                    children: filteredTreats.map((treat) {
                      return _buildRealPhotoTreatCard(treat);
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // WIDGET BANNER PROFESSIONAL
  // ==========================================
  // ==========================================
  // WIDGET BANNER PROFESSIONAL (HIGH CONTRAST & AVATAR)
  // ==========================================
  Widget _buildProfessionalBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B192C), // Dark Royal Navy Solid
            Color(0xFF1E3E62), // Rich Navy Accent
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFFFD700).withOpacity(0.4), // Accent Gold Border
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B192C).withOpacity(0.5),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Light Glow
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFD700).withOpacity(0.12),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Banner: Slot Logo WeLink & Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SLOT LOGO WELINK
                    Image.asset(
                      'assets/images/logo_welink.png',
                      height: 26,
                      errorBuilder: (context, error, stackTrace) {
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD700),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.link,
                                  color: Color(0xFF0B192C), size: 16),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "WeLink",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    // Badge Reward
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFD700).withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        "SPECIAL TREAT",
                        style: TextStyle(
                          color: Color(0xFF0B192C),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Content Row (Teks Kiri + Avatar Profil Kanan)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Selamat Ulang Tahun!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Nikmati penawaran istimewa dan reward eksklusif dari merchant mitra WeLink khusus di bulan bahagia ini.",
                            style: TextStyle(
                              fontSize: 11.5,
                              color: const Color(0xFFE2E8F0),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),

                    // AVATAR PROFIL USER + GOLD BADGE
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 34,
                            backgroundColor: Color(0xFF1E293B),
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=200&auto=format&fit=crop",
                            ),
                          ),
                        ),
                        // Badge Emas Kecil di Pojok Bawah
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF0B192C),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.workspace_premium_rounded,
                            size: 13,
                            color: Color(0xFF0B192C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // WIDGET FILTER KATEGORI
  // ==========================================
  Widget _buildCategoryFilter() {
    final List<String> categories = [
      "Semua",
      "Food & Beverage",
      "Beauty & Spa",
      "Shopping",
      "Entertainment"
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isSelected = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = cat;
                });
              },
              selectedColor: AppColors.deepBlue,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.deepBlue
                      : Colors.black.withOpacity(0.08),
                ),
              ),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }

  // ==========================================
  // WIDGET CARD MERCHANT (DENGAN FOTO REAL)
  // ==========================================
  Widget _buildRealPhotoTreatCard(Map<String, dynamic> treat) {
    bool isClaimed = treat["isClaimed"];

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FOTO REAL MERCHANT (Replace Emoji/Avatar)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  treat["imageUrl"],
                  width: 54,
                  height: 54,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 54,
                    height: 54,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.store, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Detail Merchant
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          treat["merchant"],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.deepBlue,
                          ),
                        ),
                        // Badge Promo Tag
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            treat["tag"],
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD97706),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded,
                            size: 12, color: Colors.grey.shade500),
                        const SizedBox(width: 2),
                        Text(
                          treat["location"],
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Judul Voucher
          Text(
            treat["title"],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            treat["subtitle"],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 10),

          // Expiry & Button Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time_filled_rounded,
                      size: 13, color: Colors.amber.shade800),
                  const SizedBox(width: 4),
                  Text(
                    treat["expiry"],
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.amber.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    treat["isClaimed"] = !treat["isClaimed"];
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        !isClaimed
                            ? "Berhasil mengklaim voucher ${treat['merchant']}!"
                            : "Klaim dibatalkan.",
                      ),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isClaimed ? Colors.grey.shade200 : AppColors.deepBlue,
                  foregroundColor:
                      isClaimed ? Colors.grey.shade600 : Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    if (isClaimed) ...[
                      const Icon(Icons.check_circle, size: 12),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      isClaimed ? "Diclaim" : "Klaim",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
