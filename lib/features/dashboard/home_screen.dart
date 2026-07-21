import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart'; // Pastikan path ini sesuai
import '../profile/birthday_treat_screen.dart';
import '../profile/transaction_history_screen.dart';
import '../profile/invite_friends_screen.dart';
import '../profile/promo_center_screen.dart';
import '../reward/reward_screen.dart';
import '../home/active_membership_screen.dart';
import '../home/streak_screen.dart';

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
      "subtitle": "Celebrate with exclusive gifts",
      "tag": "Hadiah",
    },
    {
      "icon": Icons.receipt_long,
      "bgColor": Colors.blue.shade100,
      "iconColor": Colors.blue.shade800,
      "title": "Transaction History",
      "subtitle": "Review your past activities",
      "tag": "Transaksi",
    },
    {
      "icon": Icons.person_add_alt_1,
      "bgColor": const Color(0xffe8e7fd),
      "iconColor": Colors.indigo.shade800,
      "title": "Invite Friends",
      "subtitle": "Earn points for every referral",
      "tag": "Referral"
    },
    {
      "icon": Icons.confirmation_number_outlined,
      "bgColor": Colors.amber.shade100,
      "iconColor": Colors.amber.shade900,
      "title": "Promo Center",
      "subtitle": "All your vouchers in one place",
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
                Padding(
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
                              setState(() {
                                _searchQuery = "";
                              });
                            },
                            child: const Text("Batal",
                                style: TextStyle(color: Colors.red)),
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
                                  side: BorderSide(
                                      color: Colors.black.withOpacity(0.05)),
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
                                child: Text("Menu tidak ditemukan... 😢",
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            )
                          : Column(
                              children: filteredMenus.map((menu) {
                                return _buildMenuItem(
                                  context,
                                  menu["icon"],
                                  menu["bgColor"],
                                  menu["iconColor"],
                                  menu["title"],
                                  menu["subtitle"],
                                );
                              }).toList(),
                            ),
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      _buildStatsCard(),
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
        color: AppColors.deepBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50,
            top: -30,
            child: Transform.rotate(
              angle: -0.25,
              child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  'assets/images/logo_Welink.png',
                  width: 260,
                  height: 260,
                  fit: BoxFit.contain,
                  color: Colors.white,
                  colorBlendMode: BlendMode.srcIn,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
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
                            Text("Welcome back,",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 13)),
                            const Text("Yepta Fredo",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Container(
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
                                  Text("GOLD MEMBER",
                                      style: TextStyle(
                                          color: AppColors.accentGold,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ],
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
                              Text("Semarang",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
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
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
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
                              setState(() {
                                _searchQuery = "";
                              });
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none),
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

  // ==========================================
  // STATS GRID CARD (SUDAH FIXED TEXT WRAP)
  // ==========================================
  Widget _buildStatsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 8))
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
                    value: "2,350",
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
                    value: "4",
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
                    value: "4",
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

  // WIDGET ITEM STATS DENGAN PENCEGAHAN OVERFLOW ICON
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
            // Expanded memastikan teks membungkus (wrap) jika kepanjangan
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
            return _buildMenuItem(
              context,
              menu["icon"],
              menu["bgColor"],
              menu["iconColor"],
              menu["title"],
              menu["subtitle"],
            );
          }).toList(),
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    Color bgColor,
    Color iconColor,
    String title,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          Widget destinationScreen;
          switch (title) {
            case "Birthday Treat":
              destinationScreen = const BirthdayTreatScreen();
              break;
            case "Transaction History":
              destinationScreen = const TransactionHistoryScreen();
              break;
            case "Invite Friends":
              destinationScreen = const InviteFriendsScreen();
              break;
            case "Promo Center":
              destinationScreen = const PromoCenterScreen();
              break;
            default:
              return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationScreen),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.black.withOpacity(0.3),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PromoCarouselBanner extends StatefulWidget {
  const PromoCarouselBanner({super.key});

  @override
  State<PromoCarouselBanner> createState() => _PromoCarouselBannerState();
}

class _PromoCarouselBannerState extends State<PromoCarouselBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> _promoList = [
    {
      "title": "Gourmet Haven",
      "subtitle": "Get 20% cashback on all\norders today.",
      "image":
          "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=600&auto=format&fit=crop"
    },
    {
      "title": "Coffee Time",
      "subtitle": "Buy 1 Get 1 Free for all\nEspresso base items.",
      "image":
          "https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=600&auto=format&fit=crop"
    },
    {
      "title": "Gadget Fest",
      "subtitle": "Special tech discount up to\n50% off this weekend.",
      "image":
          "https://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=600&auto=format&fit=crop"
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _promoList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(_currentPage,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) => setState(() => _currentPage = page),
            itemCount: _promoList.length,
            itemBuilder: (context, index) {
              final promo = _promoList[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                        image: NetworkImage(promo["image"]!),
                        fit: BoxFit.cover)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColors.deepBlue.withOpacity(0.95),
                            AppColors.deepBlue.withOpacity(0.3)
                          ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(promo["title"]!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(promo["subtitle"]!,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 13,
                                      height: 1.3))),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.deepBlue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0),
                                elevation: 0),
                            child: const Text("Claim Offer",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              _promoList.length,
              (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.deepBlue
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4)))),
        ),
      ],
    );
  }
}
