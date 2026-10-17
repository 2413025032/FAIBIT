# AI DECLARATION — FAIBIT

# 1. Informasi Proyek

- Nama aplikasi: FAIBIT (Fast Arithmetic Interface + Bit)
- Mata kuliah: Pemrograman Mobile
- Platform: Android
- Framework: Flutter
- Bahasa pemrograman: Dart

# 2. Tools AI yang Digunakan

Dalam pengembangan FAIBIT, AI digunakan sebagai alat bantu untuk mendukung proses pemrograman, debugging, dan penyempurnaan antarmuka.

Tools yang digunakan:
- GitHub Copilot: membantu memberikan saran kode, melakukan perubahan kode berdasarkan instruksi, dan membantu menganalisis masalah pada aplikasi.
- ChatGPT: membantu merencanakan fitur, menyusun kebutuhan aplikasi, mengevaluasi solusi teknis, serta mendampingi proses debugging dan dokumentasi.

AI digunakan sebagai alat bantu, bukan pengganti pemahaman dan tanggung jawab pengembang terhadap kode aplikasi.

# 3. Pembagian Kontribusi Pengembangan

# Kontribusi Pengembang

Pengembang bertanggung jawab atas:
- Menentukan konsep, tujuan, dan sasaran pengguna FAIBIT.
- Menetapkan fitur pembelajaran sistem bilangan yang sesuai dengan kebutuhan siswa SMK.
- Menentukan alur penggunaan dan kebutuhan antarmuka aplikasi.
- Menyiapkan aset visual dan maskot Fai.
- Menguji aplikasi, mengevaluasi hasil perubahan, dan menentukan perbaikan yang diperlukan.
- Memeriksa hasil bantuan AI sebelum digunakan dalam aplikasi.

# Kontribusi AI

AI dimanfaatkan untuk:
- Memberikan saran implementasi kode Flutter dan Dart.
- Membantu menganalisis bug dan mengusulkan perbaikan.
- Membantu menyempurnakan navigasi, pengelolaan riwayat kuis, dan tampilan aplikasi.
- Membantu penyusunan dokumentasi proyek.

Implementasi akhir tetap perlu diperiksa dan diuji oleh pengembang agar sesuai dengan kebutuhan aplikasi.

# 4. Studi Kasus Penggunaan AI

# Studi Kasus 1 — Debugging Riwayat Kuis

Masalah: Pada tahap pengujian, aplikasi pernah menampilkan pesan kesalahan `setState() callback argument returned a Future`.

Bantuan AI: AI digunakan untuk membantu menganalisis penyebab kesalahan dan mengusulkan perbaikan pada alur pemuatan data riwayat kuis.

Evaluasi pengembang: Pengembang menguji kembali halaman riwayat setelah perubahan diterapkan. Pada pengujian berikutnya, pesan kesalahan tersebut tidak lagi muncul.

Pembelajaran: Saran AI perlu diverifikasi melalui pengujian aplikasi. Kode yang terlihat benar belum tentu berjalan sesuai harapan ketika digunakan.

# Studi Kasus 2 — Perbaikan Navigasi dan Filter Riwayat

Masalah: Pada pengujian, pernah ditemukan ketidaksesuaian antara tab navigasi yang dipilih dan halaman yang ditampilkan, serta filter Challenge yang belum menampilkan data sebagaimana diharapkan.

Bantuan AI: AI membantu menelusuri alur navigasi, kategori riwayat, dan konsistensi data yang digunakan.

Evaluasi pengembang: Setelah perubahan diterapkan, pengembang menguji kembali navigasi dan tampilan riwayat pada perangkat. Hasil pengujian menunjukkan navigasi kembali berfungsi dan masalah tampilan sebelumnya tidak lagi muncul.

Pembelajaran: Perbaikan bug perlu diuji pada alur penggunaan yang sebenarnya, bukan hanya mengandalkan hasil analisis AI.

# 5. Keterbatasan AI dan Evaluasi Kritis

AI dapat memberikan saran yang tidak sesuai dengan struktur proyek, menghasilkan perubahan yang memerlukan penyesuaian, atau belum mendeteksi masalah yang baru terlihat saat aplikasi dijalankan.

Oleh karena itu, pengembang perlu:
1. Memahami kode yang dihasilkan atau diubah oleh AI.
2. Memeriksa kesesuaian solusi dengan kebutuhan aplikasi.
3. Menjalankan pengujian setelah perubahan.
4. Mengevaluasi kembali hasilnya apabila muncul kesalahan baru.

Penggunaan AI tidak menghilangkan tanggung jawab pengembang terhadap kualitas, fungsi, dan pemeliharaan aplikasi.

# 6. Kesimpulan

Penggunaan AI dalam pengembangan FAIBIT membantu mempercepat proses pemrograman dan debugging. Namun, keputusan mengenai kebutuhan fitur, evaluasi hasil, pengujian aplikasi, dan penerimaan perubahan tetap menjadi tanggung jawab pengembang.

Dokumen ini disusun sebagai bentuk transparansi penggunaan AI dalam pengerjaan proyek FAIBIT.
