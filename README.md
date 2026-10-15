# FAIBIT — Fast Arithmetic Interface + Bit

FAIBIT adalah aplikasi pembelajaran berbasis Android yang dikembangkan menggunakan Flutter untuk membantu siswa kelas X SMK, khususnya bidang TJKT, mempelajari sistem bilangan secara interaktif.

## Tujuan Aplikasi

FAIBIT dirancang untuk membantu siswa memahami sistem bilangan dan konversinya melalui materi terstruktur, latihan soal, serta tantangan berbatas waktu.

## Fitur Utama

- **Materi Pembelajaran:** mempelajari sistem bilangan desimal, biner, oktal, dan heksadesimal beserta konversinya.
- **Latihan Santai:** mengerjakan soal tanpa batas waktu.
- **Challenge:** mengerjakan soal dengan batas waktu.
- **Pembahasan Jawaban:** melihat umpan balik dan penjelasan setelah menjawab soal.
- **Riwayat Kuis:** melihat hasil latihan dan challenge yang telah diselesaikan.
- **Profil dan Pengaturan:** mengatur informasi profil serta preferensi aplikasi.
- **Maskot Fai:** karakter pendamping untuk membuat pengalaman belajar lebih menarik.

## Teknologi yang Digunakan

- Flutter
- Dart
- Visual Studio Code
- SharedPreferences untuk penyimpanan lokal riwayat kuis

## Struktur Proyek

```text
faibit/
├── android/
├── assets/
├── lib/
├── test/
├── pubspec.yaml
└── README.md
```

Folder `lib/` berisi kode utama aplikasi, `assets/` menyimpan aset visual, dan `test/` berisi pengujian aplikasi.

## Cara Menjalankan Aplikasi

1. Instal Flutter SDK dan Android Studio atau siapkan Android SDK.
2. Clone repositori FAIBIT.
3. Buka folder proyek melalui terminal.
4. Jalankan perintah berikut:

```bash
flutter pub get
flutter run
```

Pastikan perangkat Android atau emulator sudah terhubung.

## Dokumentasi Tampilan

Screenshot aplikasi akan ditambahkan pada bagian ini untuk memperlihatkan halaman Beranda, Materi, Latihan, Challenge, Riwayat, dan Profil.

## Pengujian

Aplikasi dikembangkan dan diuji secara bertahap. Pengujian mencakup navigasi, pengerjaan kuis, umpan balik jawaban, penyimpanan riwayat, dan tampilan antarmuka.

## Pengembang

Proyek ini dikembangkan sebagai tugas Ujian Tengah Semester mata kuliah Pemrograman Mobile.
