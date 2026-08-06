import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  // State Filter & Search
  String _selectedStatus = "Semua";
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  // Mock Data Transaksi Realistis
  final List<Map<String, dynamic>> _transactions = [
    {
      "id": "TRX-882901",
      "title": "Kopi Kita - Gunungpati",
      "category": "Food & Beverage",
      "date": "21 Jul 2026, 14:20 WIB",
      "amount": "- Rp 28.000",
      "isExpense": true,
      "status": "Selesai",
      "paymentMethod": "WeLink Pay",
      "imageUrl": "https://picsum.photos/id/1060/200/200",
    },
    {
      "id": "TRX-882894",
      "title": "Glow & Relax Spa",
      "category": "Beauty & Spa",
      "date": "20 Jul 2026, 16:45 WIB",
      "amount": "- Rp 150.000",
      "isExpense": true,
      "status": "Selesai",
      "paymentMethod": "Kartu Kredit / Debit",
      "imageUrl": "https://picsum.photos/id/64/200/200",
    },
    {
      "id": "TRX-882710",
      "title": "Top Up WeLink Balance",
      "category": "Top Up",
      "date": "19 Jul 2026, 09:12 WIB",
      "amount": "+ Rp 200.000",
      "isExpense": false,
      "status": "Selesai",
      "paymentMethod": "Virtual Account BCA",
      "imageUrl": "https://picsum.photos/id/160/200/200",
    },
    {
      "id": "TRX-882655",
      "title": "Bake & Batter Bakery",
      "category": "Food & Beverage",
      "date": "18 Jul 2026, 19:30 WIB",
      "amount": "- Rp 45.000",
      "isExpense": true,
      "status": "Diproses",
      "paymentMethod": "WeLink Pay",
      "imageUrl": "https://picsum.photos/id/102/200/200",
    },
    {
      "id": "TRX-882420",
      "title": "Cinema XXI - DP Mall",
      "category": "Entertainment",
      "date": "15 Jul 2026, 13:00 WIB",
      "amount": "- Rp 85.000",
      "isExpense": true,
      "status": "Gagal",
      "paymentMethod": "WeLink Pay",
      "imageUrl": "https://picsum.photos/id/1043/200/200",
    },
    {
      "id": "TRX-882119",
      "title": "Style Fashion Store",
      "category": "Shopping",
      "date": "10 Jul 2026, 11:15 WIB",
      "amount": "- Rp 175.000",
      "isExpense": true,
      "status": "Selesai",
      "paymentMethod": "QRIS",
      "imageUrl": "https://picsum.photos/id/1070/200/200",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _transactions.where((trx) {
      final matchesStatus =
          _selectedStatus == "Semua" || trx["status"] == _selectedStatus;
      final matchesSearch = trx["title"]
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          trx["id"]
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();

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
          "Riwayat Transaksi",
          style: TextStyle(
            color: AppColors.deepBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. STATS SUMMARY & SEARCH BAR
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0B192C), Color(0xFF1E3E62)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Total Pengeluaran Bulan Ini",
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Rp 483.000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.calendar_month_rounded,
                                color: Color(0xFFFFD700), size: 14),
                            SizedBox(width: 4),
                            Text(
                              "Juli 2026",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Cari toko atau ID transaksi...",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Colors.grey.shade500,
                      size: 20,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = "";
                              });
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. STATUS FILTER CHIPS
          Container(
            width: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children:
                    ["Semua", "Selesai", "Diproses", "Gagal"].map((status) {
                  final isSelected = _selectedStatus == status;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(status),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedStatus = status;
                          });
                        }
                      },
                      selectedColor: AppColors.deepBlue,
                      backgroundColor: const Color(0xFFF1F5F9),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none,
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // 3. TRANSACTION LIST
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Tidak ada transaksi ditemukan",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return _buildTransactionCard(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // WIDGET ITEM CARD TRANSAKSI
  Widget _buildTransactionCard(Map<String, dynamic> item) {
    Color statusColor;
    Color statusBg;

    switch (item["status"]) {
      case "Selesai":
        statusColor = const Color(0xFF166534);
        statusBg = const Color(0xFFDCFCE7);
        break;
      case "Diproses":
        statusColor = const Color(0xFFB45309);
        statusBg = const Color(0xFFFEF3C7);
        break;
      case "Gagal":
        statusColor = const Color(0xFF991B1B);
        statusBg = const Color(0xFFFEE2E2);
        break;
      default:
        statusColor = Colors.grey;
        statusBg = Colors.grey.shade100;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showDetailBottomSheet(item),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Gambar Merchant / Transaksi (Diperbaiki)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item["imageUrl"],
                    width: 46,
                    height: 46,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 46,
                        height: 46,
                        color: const Color(0xFFE2E8F0),
                        child: const Icon(
                          Icons.storefront_rounded,
                          color: AppColors.deepBlue,
                          size: 22,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 46,
                        height: 46,
                        color: const Color(0xFFF1F5F9),
                        child: const Center(
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 14),

                // Info Utama Transaksi
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepBlue,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item["date"],
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item["status"],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Nominal Transaksi
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item["amount"],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: item["isExpense"]
                            ? const Color(0xFF0F172A)
                            : const Color(0xFF16A34A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item["paymentMethod"],
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // MODAL BOTTOM SHEET DETAIL RECEIPT
  void _showDetailBottomSheet(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Detail Transaksi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepBlue,
                ),
              ),
              const SizedBox(height: 20),

              // Gambar Besar di BottomSheet (Diperbaiki)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  item["imageUrl"],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: const Color(0xFFE2E8F0),
                    child: const Icon(Icons.storefront_rounded,
                        size: 30, color: AppColors.deepBlue),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                item["amount"],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: item["isExpense"]
                      ? AppColors.deepBlue
                      : const Color(0xFF16A34A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item["title"],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 24),
              const Divider(height: 1, color: Color(0xFFE2E8F0)),
              const SizedBox(height: 16),

              _buildDetailRow("No. Referensi", item["id"]),
              _buildDetailRow("Tanggal & Waktu", item["date"]),
              _buildDetailRow("Kategori", item["category"]),
              _buildDetailRow("Metode Pembayaran", item["paymentMethod"]),
              _buildDetailRow("Status", item["status"],
                  isStatus: true, statusText: item["status"]),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Tutup Struk",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isStatus = false, String statusText = ""}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          if (isStatus)
            Text(
              statusText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: statusText == "Selesai"
                    ? Colors.green.shade700
                    : (statusText == "Diproses"
                        ? Colors.amber.shade800
                        : Colors.red.shade700),
              ),
            )
          else
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.deepBlue,
              ),
            ),
        ],
      ),
    );
  }
}
