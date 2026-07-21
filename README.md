# WeLink — Shared Loyalty Platform for UMKM

WeLink adalah platform loyalitas bersama yang dirancang untuk membantu pelaku UMKM (Usaha Mikro, Kecil, dan Menengah) di Indonesia membangun program loyalitas pelanggan secara kolektif dan efisien. Dikembangkan sebagai proyek untuk kompetisi **GEMASTIK — Business Development**.

## 💡 Latar Belakang
Banyak UMKM kesulitan membangun program loyalitas sendiri karena keterbatasan sumber daya. WeLink hadir sebagai solusi bersama (shared platform) di mana pelanggan bisa mengumpulkan dan menukarkan poin lintas UMKM yang tergabung dalam jaringan.

## 🛠️ Tech Stack & Arsitektur
- **Customer App** — Flutter (mobile)
- **Merchant App** — Flutter (mobile)
- **Backend** — NestJS
- **Admin Dashboard** — React (web)

## ✨ Fitur Utama
- Sistem poin loyalitas lintas UMKM dengan formula perhitungan poin
- QR code dengan masa berlaku (expiry) untuk transaksi & penukaran poin
- Fitur *birthday treat* — reward otomatis untuk pelanggan di hari ulang tahun
- Logika scan keanggotaan (membership scan) untuk verifikasi pelanggan
- Dashboard admin berbasis web untuk pengelolaan merchant

## 👥 Peran Saya
Sebagai **mobile developer & product designer** dalam tim, saya bertanggung jawab atas:
- Pengembangan aplikasi Flutter untuk Customer App dan Merchant App
- Perancangan alur produk (product rules): formula poin, logika expiry QR, dan skema scan keanggotaan
- Desain pengalaman pengguna (UX) untuk kedua aplikasi mobile

## 👨‍💻 Tim
Dikembangkan bersama tim untuk kompetisi GEMASTIK Business Development.

## 🚀 Cara Menjalankan
1. Clone repository ini
2. Jalankan `flutter pub get` untuk install dependencies
3. Jalankan `flutter run` untuk memulai aplikasi
