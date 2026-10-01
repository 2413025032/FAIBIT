# FAIBIT V2 — Product & UI Rules

Dokumen ini menjadi acuan bersama untuk pengembangan prototype FAIBIT setelah keputusan produk, alur, dan identitas visual diperbarui. Dokumen ini dipakai bersama file `wireframe_faibit_v2.png` sebagai referensi 

## 1. Identitas Produk

**Nama aplikasi:** FAIBIT  
**Fokus:** aplikasi pembelajaran Sistem Bilangan untuk siswa kelas X SMK/TJKT.  
**Peran Fai:** teman belajar digital yang memberikan feedback, motivasi, dan pendampingan pada momen belajar yang relevan.

### Materi utama
1. Desimal
2. Biner
3. Oktal
4. Heksadesimal
5. Konversi

### Batasan scope
Versi awal tidak menggunakan:
- login/register;
- password;
- akun online;
- XP;
- level;
- leaderboard;
- multiplayer;
- teacher dashboard;
- video pembelajaran.

Database/local storage akan ditambahkan pada tahap lanjutan. Prototype UI boleh memakai mock/in-memory data.

---

## 2. Navigasi Utama

Bottom navigation memiliki **4 tujuan utama**:

**Beranda | Materi | Riwayat | Profil**

Latihan dan Challenge **bukan tujuan utama navbar**. Keduanya diakses dari:
- Beranda;
- halaman Materi Selesai.

Penggunaan 4 tujuan utama konsisten dengan panduan Android untuk navigation bar pada layar ringkas, yang menempatkan 3–5 tujuan pada hierarki navigasi yang sama.
**Sumber:** Android Developers, *Layouts and navigation patterns*.

### Bottom navigation tampil pada
- Beranda
- Daftar Materi
- Riwayat
- Profil

### Bottom navigation tidak tampil pada
- Detail Materi
- Baca Materi
- Materi Selesai
- Persiapan Latihan
- Soal Latihan
- Feedback
- Hasil Latihan
- Persiapan Challenge
- Soal Challenge
- Hasil Challenge
- Detail Riwayat
- Edit Profil
- Pengaturan
- Sumber Materi
- Tentang Aplikasi

Pada halaman turunan, tombol **Back** selalu kembali satu tingkat ke halaman sebelumnya.

---

## 3. Alur Awal

### Splash
Splash menampilkan:
- brand FAIBIT;
- tagline/identitas aplikasi;
- slot visual Fai;
- indikator sederhana.

Fai tidak harus menjadi elemen terbesar pada layar.

### Identitas Pengguna
Data awal:
- Nama
- Kelas
- Sekolah

Ini adalah **identitas pengguna**, bukan sistem akun.

Tombol utama:
**Mulai Belajar**

Data belum disimpan permanen pada prototype.

---

## 4. Beranda

Beranda berisi:
- brand FAIBIT;
- pengaturan;
- foto profil pengguna;
- nama;
- kelas;
- sekolah bila dibutuhkan;
- sapaan;
- pesan motivasi;
- Progress Materi;
- menu Materi;
- menu Latihan;
- menu Challenge;
- menu Riwayat;
- slot Fai.

### Progress Materi
Progress Beranda dihitung berdasarkan **materi utuh yang selesai**, dari total 5 materi.

Satu materi dianggap selesai jika seluruh bagiannya telah selesai dipelajari.

Contoh:
- 2 dari 5 materi selesai = 40%.

Progress **tidak dihitung dari skor quiz**.

---

## 5. Materi

Alur:

**Beranda/Navbar → Daftar Materi → Detail Materi → Baca Bagian → Materi Selesai**

Semua 5 materi **terbuka sejak awal**.

Tidak ada sistem unlock.

Status selesai hanya menjadi indikator kemajuan belajar.

### Detail Materi
Menampilkan:
- nama materi;
- progress materi;
- daftar bagian;
- status bagian.

Progress pada Detail Materi dihitung berdasarkan bagian materi.

Contoh:
- 3 dari 4 bagian selesai = 75%.

### Baca Materi
Menampilkan:
- judul bagian;
- isi penjelasan;
- contoh;
- slot visual bila diperlukan;
- tombol Sebelumnya;
- tombol Selanjutnya;
- tindakan Tandai Selesai.

Setelah bagian terakhir selesai, tampil **Materi Selesai**.

### Materi Selesai
Fai memberikan feedback singkat.

Aksi:
- Latihan Materi Ini
- Challenge Materi Ini
- Kembali ke Materi
- Kembali ke Beranda

Jika pengguna masuk ke Latihan/Challenge melalui tombol “Materi Ini”, materi yang dipilih otomatis mengikuti materi yang baru selesai.

---

## 6. Latihan Santai

### Akses
- Beranda → Latihan
- Materi Selesai → Latihan Materi Ini

### Persiapan Latihan
Jika masuk dari Beranda:
- pilih materi:
  - Semua Materi
  - Desimal
  - Biner
  - Oktal
  - Heksadesimal
  - Konversi
- informasi jumlah soal;
- keterangan **tanpa batas waktu**;
- tombol Mulai Latihan.

Jika masuk dari materi tertentu:
- materi langsung terpilih;
- tidak perlu memilih ulang.

Semua materi tetap terbuka.

### Soal Latihan
Menampilkan:
- nomor soal;
- total soal;
- progress;
- pertanyaan;
- empat pilihan;
- navigasi soal.

Tidak ada bottom navigation.

### Feedback
Menampilkan:
- status benar/salah;
- jawaban pengguna;
- jawaban benar;
- pembahasan;
- Fai pada ukuran yang tidak mengganggu fokus.

### Hasil Latihan
Menampilkan:
- materi;
- jumlah soal;
- benar;
- salah;
- skor;
- durasi;
- feedback Fai.

Hasil **otomatis dicatat ke Riwayat** tanpa tombol simpan manual.

---

## 7. Challenge

### Akses
- Beranda → Challenge
- Materi Selesai → Challenge Materi Ini

### Persiapan Challenge
Menampilkan:
- pilihan materi;
- jumlah soal;
- batas waktu;
- tingkat tantangan bila dibutuhkan;
- tombol Mulai Challenge.

Jika masuk dari materi tertentu, materi langsung terpilih.

**Timer belum berjalan pada halaman persiapan.**

### Mode Challenge
Tema visual berubah ke **Orange + Amber**.

Timer dimulai hanya setelah pengguna menekan **Mulai Challenge**.

Format timer wajib **MM:SS**.

Contoh:
87 detik → `01:27`.

### Hasil Challenge
Menampilkan:
- materi;
- jumlah soal;
- benar;
- salah;
- skor;
- durasi;
- Fai versi Challenge.

Hasil otomatis masuk Riwayat.

---

## 8. Aturan Keluar dari Latihan/Challenge

Jika pengguna menekan Back saat sedang mengerjakan aktivitas:

### Dialog Latihan
**Keluar dari latihan?**  
Progress pengerjaan tidak akan disimpan.

- Batal
- Keluar

### Dialog Challenge
**Keluar dari challenge?**  
Progress pengerjaan tidak akan disimpan.

- Batal
- Keluar

Back pada halaman persiapan boleh langsung kembali ke halaman sebelumnya karena aktivitas belum dimulai.

---

## 9. Riwayat

Riwayat dapat difilter:
- Semua
- Materi
- Latihan
- Challenge

Setiap item riwayat **harus dapat ditekan**.

### Detail Riwayat — Latihan
Minimal menampilkan:
- jenis aktivitas;
- materi;
- tanggal;
- jam;
- durasi;
- jumlah soal;
- benar;
- salah;
- skor.

### Detail Riwayat — Challenge
Informasi sama seperti latihan, dengan tipe Challenge.

### Detail Riwayat — Materi
Menampilkan:
- materi;
- tanggal;
- waktu mulai;
- waktu selesai;
- durasi;
- jumlah bagian selesai.

Riwayat berasal dari aktivitas yang tersimpan pada tahap implementasi data berikutnya.

---

## 10. Profil

Profil adalah tujuan utama navbar.

Profil menampilkan data secara langsung, bukan kumpulan tombol “Ubah Nama”.

Data:
- foto profil;
- nama;
- kelas;
- sekolah.

Ada ikon pensil untuk masuk mode edit.

### Edit Profil
Field:
- Nama
- Kelas
- Sekolah

Aksi:
**Simpan**

Foto dapat diganti dari area foto.

Jika ada perubahan yang belum disimpan dan pengguna mencoba keluar, gunakan konfirmasi:
- Simpan perubahan
- Buang perubahan
- Batal

---

## 11. Foto Profil

Pengguna dapat memilih foto dari perangkat.

Foto digunakan pada:
- Profil;
- card pengguna di Beranda.

Foto pengguna tidak menggantikan slot Fai.

Implementasi pemilihan dan penyimpanan permanen dilakukan pada tahap local storage/database.

---

## 12. Pengaturan

Pengaturan berbeda dari Profil.

### Tampilan
- Light Mode
- Dark Mode
- System

### Informasi
- Sumber Materi
- Tentang Aplikasi

### Data
- Hapus Data

Dark mode harus memiliki warna surface/background/text yang sesuai, bukan sekadar membalik warna secara mentah. Green Teal tetap menjadi identitas utama dan Orange + Amber tetap digunakan sebagai aksen Challenge.

---

## 13. Sumber Materi

Sumber Materi berada di:

**Profil → Pengaturan → Sumber Materi**

Setiap materi harus mempunyai sumber yang jelas.

Format minimal yang disiapkan:
- nama penulis/lembaga;
- judul sumber;
- tahun;
- halaman/bagian bila relevan;
- URL/DOI bila tersedia.

Konten materi final **tidak boleh dimasukkan hanya berdasarkan hasil generasi AI tanpa acuan sumber**.

---

## 14. Tentang Aplikasi

Berisi informasi singkat:
- nama aplikasi;
- tujuan aplikasi;
- target pengguna;
- versi aplikasi;
- pengembang/tim;
- informasi akademik yang diperlukan.

---

## 15. Fai — Mascot & Learning Companion

### Identitas karakter
Fai adalah:
- kucing chibi;
- kepala besar;
- badan kecil;
- wajah ekspresif;
- memiliki mata, hidung, dan mulut;
- tanpa buntut;
- ujung telinga memiliki aksen mekanik/metal;
- pakaian bergaya tech explorer;
- motif angka biner 0 dan 1 menjadi bagian pakaian/detail karakter;
- memiliki elemen digital/pixel secukupnya.

Fai bukan dekorasi yang harus muncul besar pada setiap layar.

### Fungsi Fai
Fai digunakan untuk:
- menyapa;
- memberi motivasi;
- memberi feedback jawaban;
- mendampingi proses belajar;
- memberi apresiasi;
- memberi dukungan ketika jawaban belum tepat;
- memberi semangat pada Challenge.

Penggunaan karakter pendamping dapat didukung oleh konsep **social presence** dalam lingkungan belajar digital. Studi 2025 menemukan bahwa pedagogical agent animasi dapat meningkatkan pengalaman social presence, tetapi tidak menemukan perbedaan performa belajar dalam eksperimen tersebut; studi 2026 lain pada virtual companion AI melaporkan hasil yang lebih positif pada learning outcomes dalam konteksnya. Karena bukti bersifat kontekstual, Fai digunakan sebagai keputusan desain pendamping, bukan sebagai jaminan peningkatan hasil belajar.
**Sumber:** Xu et al. (2025), *British Journal of Educational Technology*; Xia et al. (2026), *British Journal of Educational Technology*.

### Ekspresi Fai
Minimal:
- Default/Menyapa
- Thinking/Berpikir
- Happy/Benar
- Encouraging/Salah
- Reading/Membaca Materi
- Surprised/Terkejut
- Challenge/Semangat
- Celebrate/Hasil

---

## 16. Warna Fai & Aplikasi

### Mode Normal
Identitas utama:

**Green Teal + Dark Gray + Off-white**

Palet implementasi utama:
- Green Teal: `#0F9D78`
- Dark Gray: `#263238`
- Off-white: `#F8FAF9`

Green Teal menjadi warna primary/accent utama.

### Mode Challenge
Identitas:

**Orange + Amber**

Palet:
- Orange: `#F97316`
- Orange Gelap: `#EA580C`
- Accent gelap: `#7C2D12`

Orange + Amber digunakan sebagai penanda visual mode Challenge.

Pemilihan warna merupakan keputusan identitas visual dan mode cue aplikasi. Literatur color psychology menunjukkan warna dapat membawa makna serta memengaruhi affect/cognition/behavior, tetapi efeknya sangat bergantung pada konteks dan tidak boleh diterjemahkan menjadi klaim universal seperti “warna tertentu pasti meningkatkan prestasi”.
**Sumber:** Elliot & Maier (2014), *Annual Review of Psychology*.

---

## 17. Tipografi

**Poppins**
- judul;
- heading;
- tombol;
- elemen utama.

**Inter**
- body text;
- deskripsi;
- teks materi;
- informasi detail.

Tujuan kombinasi ini adalah membedakan hierarchy judul dan teks isi secara konsisten.

---

## 18. Card & Button

### Card
Gunakan **filled card** dengan:
- permukaan putih/off-white;
- rounded corner;
- spacing yang cukup;
- hierarchy isi yang jelas.

Tidak semua card harus diberi border tebal.

### Button
Gunakan **elevated/filled rounded button** untuk aksi utama.

Contoh:
- Mulai Belajar
- Mulai Latihan
- Mulai Challenge
- Simpan

Aksi sekunder dapat memakai outlined/text button sesuai konteks.

---

## 19. Icon

Gunakan icon yang:
- sederhana;
- mudah dikenali;
- konsisten satu gaya;
- tidak dekoratif berlebihan.

Contoh:
- Beranda → home
- Materi → menu_book
- Riwayat → history
- Profil → person
- Pengaturan → settings
- Challenge → bolt/emoji_events
- Edit → edit
- Sumber → menu_book/source
- Hapus → delete

Icon berfungsi membantu pengenalan tindakan/destinasi, bukan sekadar hiasan.

---

## 20. Aksesibilitas Visual

Kontras teks dan latar harus diperiksa.

Sebagai acuan WCAG:
- teks biasa minimal 4.5:1;
- teks besar minimal 3:1;
- komponen/objek visual penting minimal 3:1 terhadap warna sekitar.

**Sumber:** W3C Web Accessibility Initiative, WCAG Success Criterion 1.4.3 dan 1.4.11.

---

## 21. Aturan untuk Codex

Saat mengimplementasikan FAIBIT:

1. `wireframe_faibit_v2.png` adalah referensi visual utama.
2. Dokumen ini adalah referensi perilaku, navigasi, dan keputusan desain.
3. Jangan menambahkan fitur di luar scope.
4. Jangan mengubah nama/konsep produk tanpa instruksi.
5. Jangan membuat sistem unlock.
6. Jangan membuat login/register.
7. Jangan menambahkan XP/level/leaderboard.
8. Jangan memasukkan mascot final sebelum asset Fai final tersedia.
9. Pertahankan slot Fai pada area yang sudah dirancang.
10. Jangan menaruh bottom navigation pada child flow.
11. Jangan memulai timer Challenge sebelum tombol Mulai Challenge.
12. Semua hasil latihan dan challenge harus otomatis dicatat ke riwayat pada tahap implementasi data.
13. Progress materi tidak boleh dihitung dari skor quiz.
14. Semua screen harus dapat dinavigasikan sesuai flow.
15. Hindari duplikasi class/implementasi.
16. Gunakan theme terpusat.
17. Gunakan mock data selama database belum dibuat.
18. Jangan memasukkan konten materi final sebelum sumber materi ditetapkan.

---

## 22. Daftar Screen Final

1. Splash Screen
2. Identitas Pengguna
3. Beranda
4. Daftar Materi
5. Detail Materi
6. Baca Bagian Materi
7. Materi Selesai
8. Persiapan Latihan
9. Soal Latihan
10. Feedback Jawaban
11. Hasil Latihan
12. Persiapan Challenge
13. Soal Challenge
14. Hasil Challenge
15. Riwayat Aktivitas
16. Detail Riwayat
17. Profil
18. Edit Profil
19. Pengaturan

### Subpage Pengaturan
- Sumber Materi
- Tentang Aplikasi

### Modal/Dialog
- Konfirmasi keluar dari Latihan
- Konfirmasi keluar dari Challenge
- Konfirmasi buang/simpan perubahan Profil
- Konfirmasi Hapus Data

---

## 23. Status Keputusan

**Sudah dikunci**
- Konsep aplikasi FAIBIT
- 5 materi
- Navbar 4 item
- Akses Latihan/Challenge
- Tidak ada unlock
- Alur Materi
- Alur Latihan
- Alur Challenge
- Riwayat detail
- Profil
- Pengaturan
- Foto profil
- Green Teal mode normal
- Orange + Amber mode Challenge
- Poppins + Inter
- Filled card
- Elevated/rounded button
- Fai sebagai teman belajar digital
- Fai kucing chibi tech explorer
- Fai tanpa buntut
- Motif binary pada pakaian
- Aksen mekanik pada ujung telinga
- Slot Fai tidak mendominasi UI

**Belum dikunci**
- Isi materi final
- Daftar sumber final
- Jumlah bagian masing-masing materi
- Paket soal final
- Asset/logo Fai final
- Detail ukuran/spacing UI per screen
- Teknologi local storage/database yang dipilih

---

## 24. Referensi Utama

1. Android Developers. *Layouts and navigation patterns*. Pedoman pola navigasi dan hubungan tujuan utama/halaman turunan.
2. W3C Web Accessibility Initiative. *Understanding Success Criterion 1.4.3: Contrast (Minimum)*.
3. W3C Web Accessibility Initiative. *Understanding Success Criterion 1.4.11: Non-text Contrast*.
4. Elliot, A. J., & Maier, M. A. (2014). *Color Psychology: Effects of Perceiving Color on Psychological Functioning in Humans*. Annual Review of Psychology, 65, 95–120. DOI: 10.1146/annurev-psych-010213-115035.
5. Xu et al. (2025). *Social presence: A key factor in embedding a pedagogical agent into online learning in primary education*. British Journal of Educational Technology. DOI: 10.1111/bjet.70006.
6. Xia et al. (2026). *Enhancing online learning outcomes through virtual companion AI: The role of identity anthropomorphism*. British Journal of Educational Technology. DOI: 10.1111/bjet.70072.

Catatan: keputusan seperti nama Fai, bentuk kucing chibi, palet brand, dan struktur layar merupakan keputusan desain proyek FAIBIT. Sumber penelitian dipakai untuk mendukung prinsip/pertimbangan yang relevan, bukan untuk mengklaim bahwa satu desain pasti menghasilkan efek belajar tertentu.
