import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../widgets/promo_carousel_banner.dart';
import '../widgets/home_stats_card.dart';
import '../widgets/home_menu_item.dart';
import 'member_card_screen.dart'; // Jangan lupa import halaman kartunya

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;
  String _searchQuery = "";

  final List<Map<String, dynamic>> _allMenus = [
    {
      "icon": Icons.card_giftcard,
      "bgColor": Colors.amber.shade100,
      "iconColor": Colors.amber.shade800,
      "title": "Birthday Treat",
      "subtitle": "Rayakan dengan hadiah eksklusif",
      "tag": "Hadiah",
    },
    {
      "icon": Icons.receipt_long,
      "bgColor": Colors.blue.shade100,
      "iconColor": Colors.blue.shade800,
      "title": "Transaction History",
      "subtitle": "Lihat riwayat aktivatismu",
      "tag": "Transaksi",
    },
    {
      "icon": Icons.person_add_alt_1,
      "bgColor": const Color(0xffe8e7fd),
      "iconColor": Colors.indigo.shade800,
      "title": "Invite Friends",
      "subtitle": "Dapatkan poin dari setiap undangan",
      "tag": "Referral"
    },
    {
      "icon": Icons.confirmation_number_outlined,
      "bgColor": Colors.amber.shade100,
      "iconColor": Colors.amber.shade900,
      "title": "Promo Center",
      "subtitle": "Semua vouchermu dalam satu tempat",
      "tag": "Promo"
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final safeTopPadding = topPadding > 0 ? topPadding + 16 : 56.0;

    List<Map<String, dynamic>> filteredMenus = _allMenus.where((menu) {
      return menu["title"]
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          menu["tag"]
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
    }).toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xfff5f7fb),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(safeTopPadding),
              if (_isSearchFocused)
                _buildSearchResults(filteredMenus)
              else
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const HomeStatsCard(),
                      const SizedBox(height: 24),
                      const PromoCarouselBanner(),
                      const SizedBox(height: 28),
                      _buildMenuSection(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double topPadding) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A192F),
            Color(0xFF1E3A8A),
          ],
          stops: [0.5, 1.5],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -5,
            top: -15,
            child: Opacity(
              opacity: 0.40,
              child: Image.asset(
                'assets/images/logo_welink.png',
                width: 260,
                height: 260,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: topPadding, left: 24, right: 24, bottom: 28),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(
                                  "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=150&auto=format&fit=crop",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: AppColors.accentGold,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.workspace_premium,
                                  size: 10, color: AppColors.deepBlue),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back,",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 13),
                            ),
                            const Text(
                              "Yepta Fredo",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            // TOMBOL KARTU MEMBER (YANG SUDAH DIUPDATE)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MemberCardScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.accentGold.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: AppColors.accentGold, width: 1),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.emoji_events,
                                        color: AppColors.accentGold, size: 12),
                                    SizedBox(width: 4),
                                    Text(
                                      "GOLD MEMBER",
                                      style: TextStyle(
                                          color: AppColors.accentGold,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: AppColors.accentGold, size: 14),
                              SizedBox(width: 4),
                              Text(
                                "Semarang",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "GUNUNGPATI, Kota Semarang",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 9,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: "Search rewards & merchants...",
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.4), fontSize: 14),
                    prefixIcon: Icon(Icons.search,
                        color: Colors.white.withOpacity(0.5)),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = "");
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<Map<String, dynamic>> filteredMenus) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _searchQuery.isEmpty
                    ? "Pencarian Cepat Menu"
                    : "Hasil Pencarian Menumu",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              TextButton(
                onPressed: () {
                  _searchController.clear();
                  _searchFocusNode.unfocus();
                  setState(() => _searchQuery = "");
                },
                child: const Text("Batal", style: TextStyle(color: Colors.red)),
              )
            ],
          ),
          const SizedBox(height: 8),
          if (_searchQuery.isEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _allMenus.map((menu) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ActionChip(
                      avatar: Icon(menu["icon"],
                          color: menu["iconColor"], size: 16),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black.withOpacity(0.05)),
                      label: Text(menu["tag"]),
                      onPressed: () {
                        setState(() {
                          _searchController.text = menu["title"];
                          _searchQuery = menu["title"];
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          const SizedBox(height: 16),
          filteredMenus.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Text("Menu tidak ditemukan...",
                        style: TextStyle(color: Colors.grey)),
                  ),
                )
              : Column(
                  children: filteredMenus.map((menu) {
                    return HomeMenuItem(
                      icon: menu["icon"],
                      bgColor: menu["bgColor"],
                      iconColor: menu["iconColor"],
                      title: menu["title"],
                      subtitle: menu["subtitle"],
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Your Menu",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.deepBlue,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                "View All",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepBlue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: _allMenus.map((menu) {
            return HomeMenuItem(
              icon: menu["icon"],
              bgColor: menu["bgColor"],
              iconColor: menu["iconColor"],
              title: menu["title"],
              subtitle: menu["subtitle"],
            );
          }).toList(),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
