import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Import package QR Generator
import '../../core/constants/colors.dart';

class CustomerQrScreen extends StatefulWidget {
  const CustomerQrScreen({super.key});

  @override
  State<CustomerQrScreen> createState() => _CustomerQrScreenState();
}

class _CustomerQrScreenState extends State<CustomerQrScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // DATA CUSTOMER ID UNIK (Tetap/Statis sebagai identitas data customer)
  final String _customerId = "WL-7724-0981";
  final String _customerName = "YEPTA FREDO";

  @override
  void initState() {
    super.initState();

    // Inisialisasi animasi laser scanner yang aman (2.5 detik)
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Jalankan animasi naik-turun secara terus-menerus
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose(); // Matikan animasi saat keluar halaman
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      appBar: AppBar(
        backgroundColor: AppColors.deepBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Loyalty QR Code",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.deepBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Tunjukkan QR Code ini kepada kasir",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // KARTU MEMBER UTAMA
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // KOTAK BINGKAI SCANNING QR CODE
                        Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              // Lapisan 1: GENERATOR QR CODE ASLI
                              Center(
                                child: QrImageView(
                                  data:
                                      _customerId, // Data teks yang di-encode ke QR
                                  version: QrVersions.auto,
                                  size: 200.0,
                                  backgroundColor: Colors.transparent,
                                  eyeStyle: const QrEyeStyle(
                                    eyeShape: QrEyeShape.square,
                                    color: AppColors.deepBlue,
                                  ),
                                  dataModuleStyle: const QrDataModuleStyle(
                                    dataModuleShape: QrDataModuleShape.square,
                                    color: AppColors.deepBlue,
                                  ),
                                ),
                              ),

                              // Lapisan 2: Efek Garis Laser Scanner
                              AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return Positioned(
                                    top: _animation.value * 236,
                                    left: 12,
                                    right: 12,
                                    child: Container(
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: AppColors.accentGold,
                                        borderRadius: BorderRadius.circular(2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.accentGold
                                                .withOpacity(0.8),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // PEMBATAS GARIS PUTUS-PUTUS AESTHETIC
                        Row(
                          children: List.generate(
                            15,
                            (index) => Expanded(
                              child: Container(
                                color: index % 2 == 0
                                    ? Colors.transparent
                                    : Colors.grey.shade300,
                                height: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // DETAIL DATA UNIK CUSTOMER
                        Text(
                          _customerName,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _customerId,
                          style: const TextStyle(
                            color: AppColors.deepBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.stars,
                          color: AppColors.accentGold, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        "Otomatis kumpulkan poin",
                        style: TextStyle(
                          color: AppColors.deepBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 130),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
