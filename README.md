# 📱 Aplikasi AI Chatbot Flutter

Sebuah aplikasi Flutter sederhana yang menggunakan arsitektur **MVC** untuk membangun AI Chatbot seperti ChatGPT. Aplikasi ini terintegrasi dengan **API Gemini (Google)** untuk menghasilkan respons dari AI.

---

## ✨ Fitur Utama

- Splash screen dan halaman autentikasi (login & register).
- Halaman beranda menampilkan riwayat chat.
- Halaman chat dengan respons AI menggunakan Gemini API.
- Halaman Profil, Pengaturan, dan Bantuan.
- Navigasi bawah (Bottom Navigation) untuk akses cepat ke semua halaman.

---

## 🧱 Struktur Proyek

```
lib/
  models/        # data models
  controllers/   # app logic and HTTP requests
  views/         # UI pages
  components/    # reusable widgets
```

## 🚀 Cara Menjalankan Aplikasi

1. Buka terminal dan jalankan:
   ```bash
   flutter pub get
   flutter run


## 🔐 Konfigurasi API (Gemini)
Untuk menggunakan API dari Google Gemini, kamu perlu menambahkan file konfigurasi sebagai berikut:

Buat file `lib/config/api_config.dart` dan tambahkan:

```dart
const String geminiApiKey = 'YOUR_GEMINI_API_KEY';
