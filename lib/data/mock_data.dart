import '../models/models.dart';

const materials = [
  // ============================================================
  // 1. DESIMAL
  // ============================================================
  LearningMaterial(
    'Desimal',
    'Pengenalan sistem bilangan desimal',
    '125₁₀ = 1×10² + 2×10¹ + 5×10⁰',
    sections: [
      MaterialSection(
        title: 'Pengertian Bilangan Desimal',
        content: '''
Bilangan desimal adalah sistem bilangan yang paling sering digunakan dalam kehidupan sehari-hari. Sistem ini menggunakan basis 10, sehingga mempunyai sepuluh simbol angka, yaitu 0, 1, 2, 3, 4, 5, 6, 7, 8, dan 9.

Setiap angka dalam suatu bilangan memiliki nilai yang bergantung pada posisinya. Karena itu, angka yang sama dapat mempunyai nilai berbeda ketika berada di posisi yang berbeda.
''',
        example: '''
7 → 7
70 → 70
700 → 700
7.000 → 7.000
''',
      ),
      MaterialSection(
        title: 'Basis pada Bilangan Desimal',
        content: '''
Bilangan desimal memiliki basis 10 karena terdapat sepuluh simbol yang digunakan. Setelah angka 9, penulisan berlanjut dengan menambah posisi baru di sebelah kiri.
''',
        example: '''
7 → 8 → 9 → 10 → 11

18 → 19 → 20 → 21

98 → 99 → 100 → 101
''',
      ),
      MaterialSection(
        title: 'Nilai Tempat Bilangan Desimal',
        content: '''
Nilai tempat menunjukkan nilai suatu angka berdasarkan posisinya. Pada sistem desimal, nilai tempat menggunakan pangkat 10. Perhitungan dimulai dari posisi paling kanan dengan pangkat 10⁰.
''',
        example: '''
10⁰ = 1
10¹ = 10
10² = 100
10³ = 1.000
10⁴ = 10.000
10⁵ = 100.000
''',
      ),
      MaterialSection(
        title: 'Cara Menentukan Nilai Sebuah Bilangan Desimal',
        content: '''
Untuk menguraikan sebuah bilangan desimal, setiap digit dikalikan dengan nilai tempatnya, kemudian seluruh hasil dijumlahkan.
''',
        example: '''
347 = 3 × 10² + 4 × 10¹ + 7 × 10⁰
= 3 × 100 + 4 × 10 + 7 × 1
= 300 + 40 + 7
= 347
''',
      ),
      MaterialSection(
        title: 'Memahami Perubahan Nilai Berdasarkan Posisi',
        content: '''
Posisi digit menentukan besar nilai yang diwakilinya. Semakin ke kiri suatu digit berada, semakin besar nilai tempatnya.
''',
        example: '''
Bilangan    Nilai Digit 7
7           7
70          70
700         700
7.000       7.000
70.000      70.000
''',
      ),
      MaterialSection(
        title: 'Contoh Penguraian Bilangan Desimal',
        content: '''
Penguraian bilangan desimal dapat dilakukan dengan menjumlahkan nilai setiap digit sesuai nilai tempatnya.
''',
        example: '''
648 = 600 + 40 + 8

9.071 = 9.000 + 0 + 70 + 1

45.608 = 40.000 + 5.000 + 600 + 0 + 8
''',
      ),
    ],
  ),

  // ============================================================
  // 2. BINER
  // ============================================================
  LearningMaterial(
    'Biner',
    'Pengenalan sistem bilangan biner',
    '1011₂ = 8 + 0 + 2 + 1 = 11₁₀',
    sections: [
      MaterialSection(
        title: 'Pengertian Bilangan Biner',
        content: '''
Bilangan biner adalah sistem bilangan yang menggunakan basis 2. Sistem ini hanya mempunyai dua simbol, yaitu 0 dan 1.

Setiap satu angka dalam bilangan biner disebut bit (binary digit). Contoh penulisan bilangan biner adalah 0₂, 1₂, 10₂, 101₂, dan 11010₂. Angka kecil ₂ menunjukkan bahwa bilangan menggunakan basis 2.
''',
        example: '''
0₂
1₂
10₂
101₂
11010₂
''',
      ),
      MaterialSection(
        title: 'Mengapa Biner Digunakan pada Komputer?',
        content: '''
Sistem digital bekerja dengan keadaan yang dapat dibedakan menjadi dua kondisi. Dalam representasi digital, dua kondisi tersebut dapat dinyatakan menggunakan 0 dan 1. Karena itu, biner menjadi dasar penting dalam representasi dan pengolahan informasi digital.
''',
      ),
      MaterialSection(
        title: 'Nilai Tempat Bilangan Biner',
        content: '''
Nilai tempat pada bilangan biner menggunakan pangkat 2. Perhitungannya dimulai dari posisi paling kanan dengan pangkat 2⁰, lalu meningkat satu pangkat setiap berpindah ke kiri.
''',
        example: '''
2⁰ = 1
2¹ = 2
2² = 4
2³ = 8
2⁴ = 16
2⁵ = 32
2⁶ = 64
2⁷ = 128
''',
      ),
      MaterialSection(
        title: 'Cara Menentukan Nilai Bilangan Biner',
        content: '''
Setiap digit biner dikalikan dengan nilai tempatnya. Digit 1 menunjukkan bahwa nilai tempat tersebut digunakan, sedangkan digit 0 tidak memberikan nilai pada penjumlahan.
''',
        example: '''
1011₂
= 1 × 2³ + 0 × 2² + 1 × 2¹ + 1 × 2⁰
= 8 + 0 + 2 + 1
= 11₁₀
''',
      ),
      MaterialSection(
        title: 'Pola Bilangan Biner',
        content: '''
Perubahan nilai pada bilangan biner terjadi ketika digit 1 pada posisi tertentu tidak dapat bertambah lagi. Ketika semua posisi bernilai 1 dan ditambah satu, akan terbentuk posisi baru di sebelah kiri.
''',
        example: '''
0₂ → 1₂ → 10₂ → 11₂ → 100₂ → 101₂ → 110₂ → 111₂ → 1000₂
''',
      ),
      MaterialSection(
        title: 'Bit dan Kelompok Biner',
        content: '''
Bilangan biner dapat terdiri dari beberapa bit. Sebagai contoh, 1010 merupakan bilangan 4 bit, sedangkan 11001100 merupakan bilangan 8 bit. Delapan bit dikenal sebagai satu byte.
''',
        example: '''
1010           = 4 bit
11001100       = 8 bit
101010101111   = 12 bit
''',
      ),
    ],
  ),

  // ============================================================
  // 3. OKTAL
  // ============================================================
  LearningMaterial(
    'Oktal',
    'Pengenalan sistem bilangan oktal',
    '17₈ = 1×8 + 7 = 15₁₀',
    sections: [
      MaterialSection(
        title: 'Pengertian Bilangan Oktal',
        content: '''
Bilangan oktal adalah sistem bilangan yang menggunakan basis 8. Sistem ini menggunakan delapan simbol, yaitu 0, 1, 2, 3, 4, 5, 6, dan 7. Angka 8 dan 9 tidak digunakan sebagai digit dalam bilangan oktal.

Contoh penulisan bilangan oktal: 7₈, 12₈, 45₈, dan 157₈. Angka kecil ₈ menunjukkan bahwa bilangan menggunakan basis 8.
''',
        example: '''
7₈
12₈
45₈
157₈
''',
      ),
      MaterialSection(
        title: 'Cara Kerja Basis 8',
        content: '''
Karena oktal mempunyai delapan simbol, setelah angka 7 bilangan berikutnya menggunakan posisi baru di sebelah kiri.
''',
        example: '''
5₈ → 6₈ → 7₈ → 10₈ → 11₈ → 12₈

17₈ = 1 × 8 + 7 = 15₁₀

20₈ = 2 × 8 + 0 = 16₁₀
''',
      ),
      MaterialSection(
        title: 'Nilai Tempat Bilangan Oktal',
        content: '''
Nilai tempat pada bilangan oktal menggunakan pangkat 8 dan dimulai dari 8⁰ pada posisi paling kanan.
''',
        example: '''
8⁰ = 1
8¹ = 8
8² = 64
8³ = 512
8⁴ = 4.096
''',
      ),
      MaterialSection(
        title: 'Cara Menentukan Nilai Bilangan Oktal',
        content: '''
Untuk menentukan nilai sebuah bilangan oktal, setiap digit dikalikan dengan nilai tempatnya, kemudian seluruh hasil dijumlahkan.
''',
        example: '''
157₈
= 1 × 8² + 5 × 8¹ + 7 × 8⁰
= 64 + 40 + 7
= 111₁₀

245₈
= 2 × 8² + 4 × 8¹ + 5 × 8⁰
= 128 + 32 + 5
= 165₁₀
''',
      ),
      MaterialSection(
        title: 'Hubungan Oktal dengan Biner',
        content: '''
Oktal memiliki hubungan yang dekat dengan biner karena 2³ = 8. Artinya, satu digit oktal dapat direpresentasikan menggunakan tiga bit biner.
''',
        example: '''
Oktal    Biner
0        000
1        001
2        010
3        011
4        100
5        101
6        110
7        111
''',
      ),
    ],
  ),

  // ============================================================
  // 4. HEKSADESIMAL
  // ============================================================
  LearningMaterial(
    'Heksadesimal',
    'Pengenalan sistem bilangan heksadesimal',
    '1A₁₆ = 1×16 + 10 = 26₁₀',
    sections: [
      MaterialSection(
        title: 'Pengertian Bilangan Heksadesimal',
        content: '''
Heksadesimal adalah sistem bilangan yang menggunakan basis 16. Sistem ini menggunakan angka 0–9 dan enam simbol tambahan, yaitu A, B, C, D, E, dan F.

Contoh penulisan bilangan heksadesimal: 2A₁₆, 3F₁₆, dan FF₁₆. Angka kecil ₁₆ menunjukkan bahwa bilangan menggunakan basis 16.
''',
        example: '''
2A₁₆
3F₁₆
FF₁₆
''',
      ),
      MaterialSection(
        title: 'Nilai A sampai F',
        content: '''
Dalam heksadesimal, huruf A sampai F digunakan untuk mewakili nilai 10 sampai 15.
''',
        example: '''
A = 10
B = 11
C = 12
D = 13
E = 14
F = 15

A₁₆ = 10₁₀
C₁₆ = 12₁₀
F₁₆ = 15₁₀
''',
      ),
      MaterialSection(
        title: 'Mengapa Menggunakan Huruf?',
        content: '''
Satu digit heksadesimal harus menggunakan satu simbol. Setelah angka 9 masih terdapat nilai 10–15. Nilai tersebut ditulis dengan A–F agar setiap nilai tetap direpresentasikan oleh satu digit.
''',
      ),
      MaterialSection(
        title: 'Nilai Tempat Bilangan Heksadesimal',
        content: '''
Nilai tempat pada bilangan heksadesimal menggunakan pangkat 16. Perhitungan dimulai dari posisi paling kanan dengan pangkat 16⁰, kemudian meningkat satu pangkat setiap berpindah ke kiri.
''',
        example: '''
16⁰ = 1
16¹ = 16
16² = 256
16³ = 4.096
''',
      ),
      MaterialSection(
        title: 'Cara Menentukan Nilai Bilangan Heksadesimal',
        content: '''
Untuk menentukan nilai desimal dari bilangan heksadesimal, ubah terlebih dahulu huruf A–F menjadi nilainya, lalu kalikan setiap digit dengan nilai tempatnya.
''',
        example: '''
2A₁₆
= 2 × 16¹ + 10 × 16⁰
= 32 + 10
= 42₁₀

3F₁₆
= 3 × 16¹ + 15 × 16⁰
= 48 + 15
= 63₁₀
''',
      ),
      MaterialSection(
        title: 'Hubungan Heksadesimal dengan Biner',
        content: '''
Heksadesimal berhubungan langsung dengan biner karena 2⁴ = 16. Oleh karena itu, satu digit heksadesimal dapat direpresentasikan menggunakan empat bit biner.
''',
        example: '''
0  = 0000
1  = 0001
2  = 0010
3  = 0011
4  = 0100
5  = 0101
6  = 0110
7  = 0111
8  = 1000
9  = 1001
A  = 1010
B  = 1011
C  = 1100
D  = 1101
E  = 1110
F  = 1111
''',
      ),
    ],
  ),

  // ============================================================
  // 5. KONVERSI
  // ============================================================
  LearningMaterial(
    'Konversi',
    'Konversi antar sistem bilangan',
    '10₁₀ = 1010₂',
    sections: [
      MaterialSection(
        title: 'Pengertian Konversi Sistem Bilangan',
        content: '''
Konversi sistem bilangan adalah proses mengubah bentuk penulisan suatu bilangan dari satu sistem bilangan ke sistem lainnya tanpa mengubah nilai bilangan tersebut.

Bentuk penulisannya berbeda, tetapi nilainya tetap sama.
''',
        example: '''
25₁₀ = 11001₂ = 31₈ = 19₁₆
''',
      ),
      MaterialSection(
        title: 'Desimal ke Biner',
        content: '''
Gunakan metode pembagian berulang dengan 2. Setiap sisa pembagian dicatat, lalu hasil akhirnya dibaca dari bawah ke atas.

Langkah-langkah:
1. Bagi bilangan desimal dengan 2.
2. Catat hasil bagi dan sisanya.
3. Bagi kembali hasil bagi dengan 2.
4. Ulangi sampai hasil bagi menjadi 0.
5. Baca sisa pembagian dari bawah ke atas.
''',
        example: '''
25 ÷ 2 = 12 sisa 1
12 ÷ 2 = 6 sisa 0
6 ÷ 2 = 3 sisa 0
3 ÷ 2 = 1 sisa 1
1 ÷ 2 = 0 sisa 1

Baca dari bawah → 11001₂
''',
      ),
      MaterialSection(
        title: 'Biner ke Desimal',
        content: '''
Gunakan nilai tempat berdasarkan pangkat 2. Mulai dari kanan dengan 2⁰, lalu kalikan setiap digit dengan nilai tempatnya dan jumlahkan.
''',
        example: '''
1011₂
= 1 × 2³ + 0 × 2² + 1 × 2¹ + 1 × 2⁰
= 8 + 0 + 2 + 1
= 11₁₀

11010₂
= 1 × 2⁴ + 1 × 2³ + 0 × 2² + 1 × 2¹ + 0 × 2⁰
= 16 + 8 + 0 + 2 + 0
= 26₁₀
''',
      ),
      MaterialSection(
        title: 'Desimal ke Oktal',
        content: '''
Gunakan pembagian berulang dengan 8. Catat semua sisa dan baca dari bawah ke atas.
''',
        example: '''
83 ÷ 8 = 10 sisa 3
10 ÷ 8 = 1 sisa 2
1 ÷ 8 = 0 sisa 1

Baca dari bawah → 123₈
''',
      ),
      MaterialSection(
        title: 'Oktal ke Desimal',
        content: '''
Gunakan nilai tempat berdasarkan pangkat 8. Kalikan setiap digit dengan posisi masing-masing lalu jumlahkan.
''',
        example: '''
157₈
= 1 × 8² + 5 × 8¹ + 7 × 8⁰
= 64 + 40 + 7
= 111₁₀

245₈
= 2 × 8² + 4 × 8¹ + 5 × 8⁰
= 128 + 32 + 5
= 165₁₀
''',
      ),
      MaterialSection(
        title: 'Desimal ke Heksadesimal',
        content: '''
Gunakan pembagian berulang dengan 16. Jika sisa 10–15, ubah menjadi A–F.
''',
        example: '''
254 ÷ 16 = 15 sisa 14 → E
15 ÷ 16 = 0 sisa 15 → F

Baca dari bawah → FE₁₆

100 ÷ 16 = 6 sisa 4
6 ÷ 16 = 0 sisa 6

Baca dari bawah → 64₁₆
''',
      ),
      MaterialSection(
        title: 'Heksadesimal ke Desimal',
        content: '''
Ubah A–F menjadi 10–15, kemudian gunakan nilai tempat berdasarkan pangkat 16.
''',
        example: '''
2A₁₆
= 2 × 16¹ + 10 × 16⁰
= 32 + 10
= 42₁₀

3F₁₆
= 3 × 16¹ + 15 × 16⁰
= 48 + 15
= 63₁₀
''',
      ),
      MaterialSection(
        title: 'Biner ke Oktal',
        content: '''
Karena 2³ = 8, setiap 3 bit biner dapat dipetakan menjadi satu digit oktal. Pengelompokan dimulai dari kanan.

Langkah:
1. Mulai dari bit paling kanan.
2. Kelompokkan menjadi 3 bit.
3. Jika kelompok paling kiri kurang dari 3 bit, tambahkan 0 di depan.
4. Ubah setiap kelompok menjadi satu digit oktal.
''',
        example: '''
1011011₂

Kelompok: 1 | 011 | 011
Lengkapi: 001 | 011 | 011

001 = 1
011 = 3
011 = 3

Hasil → 133₈
''',
      ),
      MaterialSection(
        title: 'Oktal ke Biner',
        content: '''
Karena satu digit oktal dapat direpresentasikan dengan 3 bit, setiap digit oktal diganti dengan pasangan biner tiga bit.
''',
        example: '''
57₈
5 = 101
7 = 111

Hasil → 101111₂

123₈
1 = 001
2 = 010
3 = 011

Hasil → 001010011₂
''',
      ),
      MaterialSection(
        title: 'Biner ke Heksadesimal',
        content: '''
Karena 2⁴ = 16, kelompokkan bit biner menjadi 4 bit dari kanan. Kelompok paling kiri dapat dilengkapi dengan 0.
''',
        example: '''
1011011₂

Kelompok: 1011 | 011
Lengkapi: 0101 | 1011

0101 = 5
1011 = B

Hasil → 5B₁₆
''',
      ),
      MaterialSection(
        title: 'Heksadesimal ke Biner',
        content: '''
Setiap digit heksadesimal diganti dengan representasi biner sebanyak 4 bit.
''',
        example: '''
3A₁₆

3 = 0011
A = 1010

Hasil → 00111010₂

5F₁₆

5 = 0101
F = 1111

Hasil → 01011111₂
''',
      ),
      MaterialSection(
        title: 'Oktal ke Heksadesimal',
        content: '''
Konversi oktal ke heksadesimal dapat dilakukan melalui biner sebagai perantara: Oktal → Biner → Heksadesimal.

Langkah:
1. Ubah setiap digit oktal menjadi 3 bit biner.
2. Gabungkan seluruh bit.
3. Kelompokkan biner menjadi 4 bit dari kanan.
4. Ubah setiap kelompok menjadi digit heksadesimal.
''',
        example: '''
725₈

7 = 111
2 = 010
5 = 101

725₈ = 111010101₂

Kelompok:
0001 | 1101 | 0101

0001 = 1
1101 = D
0101 = 5

Hasil → 1D5₁₆
''',
      ),
      MaterialSection(
        title: 'Heksadesimal ke Oktal',
        content: '''
Konversi heksadesimal ke oktal dilakukan melalui biner sebagai perantara: Heksadesimal → Biner → Oktal.

Langkah:
1. Ubah setiap digit heksadesimal menjadi 4 bit biner.
2. Gabungkan seluruh bit.
3. Kelompokkan biner menjadi 3 bit dari kanan.
4. Ubah setiap kelompok menjadi digit oktal.
''',
        example: '''
2F₁₆

2 = 0010
F = 1111

2F₁₆ = 00101111₂

Hilangkan nol di depan:
101111₂

Kelompok:
101 | 111

101 = 5
111 = 7

Hasil → 57₈
''',
      ),
      MaterialSection(
        title: 'Pola Cepat Konversi',
        content: '''
Pola berikut dapat digunakan untuk mengingat metode setiap jenis konversi.
''',
        example: '''
Desimal → Biner
Bagi 2 berulang, baca sisa dari bawah ke atas

Biner → Desimal
Gunakan pangkat 2 dan jumlahkan

Desimal → Oktal
Bagi 8 berulang, baca sisa dari bawah ke atas

Oktal → Desimal
Gunakan pangkat 8 dan jumlahkan

Desimal → Heksadesimal
Bagi 16 berulang, ubah sisa 10–15 menjadi A–F

Heksadesimal → Desimal
Gunakan pangkat 16 dan ubah A–F menjadi 10–15

Biner dan Oktal
3 bit untuk 1 digit oktal

Biner dan Heksadesimal
4 bit untuk 1 digit heksadesimal

Oktal dan Heksadesimal
Gunakan biner sebagai perantara
''',
      ),
    ],
  ),
];
const questions = [
  // Desimal
  Question(
    'D01',
    'Desimal',
    'Bilangan desimal menggunakan basis ...',
    ['2', '8', '10', '16'],
    2,
    'Sistem bilangan desimal menggunakan basis 10.',
  ),
  Question(
    'D02',
    'Desimal',
    'Simbol yang digunakan dalam bilangan desimal adalah ...',
    ['1–8', '0–9', '0–7', '0–9 dan A–F'],
    1,
    'Bilangan desimal menggunakan sepuluh simbol, yaitu 0 sampai 9.',
  ),
  Question(
    'D03',
    'Desimal',
    'Pada bilangan 572₁₀, digit 5 menempati nilai tempat ...',
    ['Satuan', 'Puluhan', 'Ratusan', 'Ribuan'],
    2,
    'Digit 5 berada di posisi ratusan, sehingga bernilai 5×10².',
  ),
  Question(
    'D04',
    'Desimal',
    'Nilai digit 4 pada bilangan 348₁₀ adalah ...',
    ['4', '8', '40', '400'],
    2,
    'Digit 4 berada pada tempat puluhan, jadi nilainya 4×10¹ = 40.',
  ),
  Question(
    'D05',
    'Desimal',
    'Penguraian nilai tempat yang benar untuk 305₁₀ adalah ...',
    [
      '3×10² + 0×10¹ + 5×10⁰',
      '3×10¹ + 0×10² + 5×10⁰',
      '3×10² + 5×10¹',
      '3×10³ + 0×10² + 5×10¹',
    ],
    0,
    'Setiap digit dikalikan dengan pangkat 10 sesuai posisinya: 300 + 0 + 5.',
  ),
  Question(
    'D06',
    'Desimal',
    'Hasil dari 2×10² + 6×10¹ + 4×10⁰ adalah ...',
    ['246', '264', '624', '2.604'],
    1,
    'Nilainya adalah 200 + 60 + 4 = 264.',
  ),
  Question(
    'D07',
    'Desimal',
    'Nilai digit 9 pada bilangan 908₁₀ adalah ...',
    ['9', '90', '908', '900'],
    3,
    'Digit 9 berada pada tempat ratusan, sehingga nilainya 9×100 = 900.',
  ),
  Question(
    'D08',
    'Desimal',
    'Nilai tempat digit 7 pada bilangan 4.705₁₀ adalah ...',
    ['Satuan', 'Puluhan', 'Ratusan', 'Ribuan'],
    2,
    'Digit 7 berada pada tempat ratusan dan bernilai 700.',
  ),
  Question(
    'D09',
    'Desimal',
    'Bilangan desimal yang muncul setelah 999₁₀ adalah ...',
    ['990', '1.000', '999', '1.009'],
    1,
    'Setelah 999, penambahan satu menghasilkan 1.000.',
  ),
  Question(
    'D10',
    'Desimal',
    'Bentuk desimal dari 6×10³ + 8×10¹ + 3×10⁰ adalah ...',
    ['6.083', '6.803', '6.830', '6.038'],
    0,
    'Perhitungannya 6.000 + 80 + 3 = 6.083.',
  ),

  // Biner
  Question(
    'B01',
    'Biner',
    'Bilangan biner menggunakan basis ...',
    ['2', '8', '10', '16'],
    0,
    'Sistem bilangan biner menggunakan basis 2.',
  ),
  Question(
    'B02',
    'Biner',
    'Simbol yang digunakan dalam bilangan biner adalah ...',
    ['1 dan 2', '0 dan 1', '0 dan 2', '1 dan 10'],
    1,
    'Bilangan biner hanya menggunakan dua simbol, yaitu 0 dan 1.',
  ),
  Question(
    'B03',
    'Biner',
    '(1011)₂ = ...₁₀',
    ['9', '10', '11', '12'],
    2,
    '1011₂ = 1×8 + 0×4 + 1×2 + 1×1 = 11₁₀.',
  ),
  Question(
    'B04',
    'Biner',
    '(11010)₂ = ...₁₀',
    ['24', '25', '26', '27'],
    2,
    '11010₂ = 16 + 8 + 0 + 2 + 0 = 26₁₀.',
  ),
  Question(
    'B05',
    'Biner',
    '(100001)₂ = ...₁₀',
    ['31', '32', '33', '34'],
    2,
    '100001₂ = 32 + 1 = 33₁₀.',
  ),
  Question(
    'B06',
    'Biner',
    '(11111)₂ = ...₁₀',
    ['29', '30', '31', '32'],
    2,
    '11111₂ = 16 + 8 + 4 + 2 + 1 = 31₁₀.',
  ),
  Question(
    'B07',
    'Biner',
    'Bilangan 1010₂ terdiri dari ... bit.',
    ['2', '3', '4', '8'],
    2,
    'Bilangan 1010 memiliki empat digit biner, sehingga terdiri dari 4 bit.',
  ),
  Question(
    'B08',
    'Biner',
    'Bilangan 11001100₂ terdiri dari ... bit.',
    ['4', '6', '8', '10'],
    2,
    'Bilangan 11001100 memiliki delapan digit biner, sehingga terdiri dari 8 bit.',
  ),
  Question(
    'B09',
    'Biner',
    'Delapan bit dikenal sebagai satu ...',
    ['word', 'byte', 'nibble', 'digit'],
    1,
    'Dalam materi FAIBIT, delapan bit dikenal sebagai satu byte.',
  ),
  Question(
    'B10',
    'Biner',
    'Bilangan yang muncul setelah 111₂ dalam urutan biner adalah ...',
    ['1111₂', '1000₂', '1010₂', '1100₂'],
    1,
    'Setelah 111₂, penambahan satu membentuk posisi baru: 1000₂.',
  ),

  // Oktal
  Question(
    'O01',
    'Oktal',
    'Bilangan oktal menggunakan basis ...',
    ['2', '8', '10', '16'],
    1,
    'Sistem bilangan oktal menggunakan basis 8.',
  ),
  Question(
    'O02',
    'Oktal',
    'Simbol yang digunakan dalam bilangan oktal adalah ...',
    ['0–7', '1–8', '0–9', '0 dan 1'],
    0,
    'Bilangan oktal menggunakan simbol 0 sampai 7.',
  ),
  Question(
    'O03',
    'Oktal',
    'Bilangan berikut yang valid sebagai bilangan oktal adalah ...',
    ['128₈', '709₈', '567₈', '890₈'],
    2,
    'Bilangan oktal hanya boleh memuat digit 0 sampai 7, sehingga 567₈ valid.',
  ),
  Question(
    'O04',
    'Oktal',
    'Nilai digit 4 pada bilangan 347₈ adalah ...',
    ['4', '32', '40', '256'],
    1,
    'Digit 4 berada di tempat 8¹, jadi nilainya 4×8 = 32.',
  ),
  Question(
    'O05',
    'Oktal',
    '(17)₈ = ...₁₀',
    ['13', '15', '17', '19'],
    1,
    '17₈ = 1×8 + 7 = 15₁₀.',
  ),
  Question(
    'O06',
    'Oktal',
    '(204)₈ = ...₁₀',
    ['132', '140', '164', '204'],
    0,
    '204₈ = 2×8² + 0×8 + 4 = 128 + 4 = 132₁₀.',
  ),
  Question(
    'O07',
    'Oktal',
    'Penguraian yang benar untuk (256)₈ adalah ...',
    [
      '2×8² + 5×8¹ + 6×8⁰',
      '2×8³ + 5×8² + 6×8¹',
      '2×10² + 5×10¹ + 6',
      '2×8⁰ + 5×8¹ + 6×8²',
    ],
    0,
    'Posisi dari kanan menggunakan 8⁰, 8¹, lalu 8².',
  ),
  Question(
    'O08',
    'Oktal',
    'Satu digit oktal setara dengan ... bit biner.',
    ['2', '3', '4', '8'],
    1,
    'Satu digit oktal dapat diwakili oleh kelompok 3 bit biner.',
  ),
  Question(
    'O09',
    'Oktal',
    'Digit terbesar yang dapat digunakan dalam bilangan oktal adalah ...',
    ['6', '7', '8', '9'],
    1,
    'Karena basisnya 8, digit oktal yang tersedia adalah 0 sampai 7.',
  ),
  Question(
    'O10',
    'Oktal',
    '(77)₈ = ...₁₀',
    ['56', '63', '70', '77'],
    1,
    '77₈ = 7×8 + 7 = 56 + 7 = 63₁₀.',
  ),

  // Heksadesimal
  Question(
    'H01',
    'Heksadesimal',
    'Bilangan heksadesimal menggunakan basis ...',
    ['2', '8', '10', '16'],
    3,
    'Sistem bilangan heksadesimal menggunakan basis 16.',
  ),
  Question(
    'H02',
    'Heksadesimal',
    'Simbol yang digunakan dalam bilangan heksadesimal adalah ...',
    ['0–7', '0–9 saja', '0–9 dan A–F', 'A–Z'],
    2,
    'Heksadesimal memakai 0–9 serta A–F untuk mewakili nilai 0–15.',
  ),
  Question(
    'H03',
    'Heksadesimal',
    'Dalam heksadesimal, nilai simbol A adalah ...',
    ['8', '10', '12', '16'],
    1,
    'Simbol A pada heksadesimal bernilai 10 dalam desimal.',
  ),
  Question(
    'H04',
    'Heksadesimal',
    'Dalam heksadesimal, nilai simbol F adalah ...',
    ['14', '15', '16', 'F'],
    1,
    'Urutan A–F mewakili 10–15, sehingga F bernilai 15.',
  ),
  Question(
    'H05',
    'Heksadesimal',
    'Nilai digit 2 pada bilangan 2B₁₆ adalah ...',
    ['2', '16', '32', '2B'],
    2,
    'Digit 2 berada di tempat 16¹, jadi nilainya 2×16 = 32.',
  ),
  Question(
    'H06',
    'Heksadesimal',
    '(1A)₁₆ = ...₁₀',
    ['16', '20', '26', '28'],
    2,
    '1A₁₆ = 1×16 + 10 = 26₁₀.',
  ),
  Question(
    'H07',
    'Heksadesimal',
    '(2F)₁₆ = ...₁₀',
    ['31', '32', '47', '52'],
    2,
    '2F₁₆ = 2×16 + 15 = 47₁₀.',
  ),
  Question(
    'H08',
    'Heksadesimal',
    'Penguraian yang benar untuk (3C)₁₆ adalah ...',
    ['3×16¹ + 12×16⁰', '3×16⁰ + 12×16¹', '3×10¹ + 12×10⁰', '3×16² + 12×16¹'],
    0,
    'C bernilai 12 dan berada pada 16⁰, sedangkan 3 berada pada 16¹.',
  ),
  Question(
    'H09',
    'Heksadesimal',
    'Satu digit heksadesimal setara dengan ... bit biner.',
    ['2', '3', '4', '8'],
    2,
    'Satu digit heksadesimal dapat diwakili oleh kelompok 4 bit biner.',
  ),
  Question(
    'H10',
    'Heksadesimal',
    'Bilangan heksadesimal yang valid adalah ...',
    ['1G₁₆', '2F₁₆', '8K₁₆', 'Z0₁₆'],
    1,
    'Simbol yang valid hanya 0–9 dan A–F, sehingga 2F₁₆ valid.',
  ),

  // Konversi
  Question(
    'K01',
    'Konversi',
    'Hasil konversi 10₁₀ ke biner adalah ...',
    ['1001₂', '1010₂', '1100₂', '1110₂'],
    1,
    '10₁₀ = 8 + 2, sehingga bentuk binernya 1010₂.',
  ),
  Question(
    'K02',
    'Konversi',
    'Hasil konversi 13₁₀ ke biner adalah ...',
    ['1011₂', '1100₂', '1101₂', '1110₂'],
    2,
    '13₁₀ = 8 + 4 + 1, sehingga menjadi 1101₂.',
  ),
  Question(
    'K03',
    'Konversi',
    'Hasil konversi 25₁₀ ke oktal adalah ...',
    ['25₈', '30₈', '31₈', '32₈'],
    2,
    '25 dibagi 8 menghasilkan sisa 1 dan 3, dibaca dari belakang menjadi 31₈.',
  ),
  Question(
    'K04',
    'Konversi',
    'Hasil konversi 42₁₀ ke heksadesimal adalah ...',
    ['2A₁₆', '2B₁₆', '3A₁₆', 'A2₁₆'],
    0,
    '42 = 2×16 + 10, dan 10 ditulis A, jadi 2A₁₆.',
  ),
  Question(
    'K05',
    'Konversi',
    'Hasil konversi 111₂ ke oktal adalah ...',
    ['3₈', '6₈', '7₈', '11₈'],
    2,
    'Kelompok 111₂ bernilai 7, sehingga 111₂ = 7₈.',
  ),
  Question(
    'K06',
    'Konversi',
    'Hasil konversi 101101₂ ke oktal adalah ...',
    ['45₈', '54₈', '55₈', '65₈'],
    2,
    'Kelompokkan 101 101; masing-masing bernilai 5, sehingga hasilnya 55₈.',
  ),
  Question(
    'K07',
    'Konversi',
    'Hasil konversi 1010₂ ke heksadesimal adalah ...',
    ['A₁₆', 'B₁₆', '10₁₆', '1A₁₆'],
    0,
    'Kelompok 1010₂ bernilai 10 desimal, yang ditulis A dalam heksadesimal.',
  ),
  Question(
    'K08',
    'Konversi',
    'Hasil konversi 11011110₂ ke heksadesimal adalah ...',
    ['CD₁₆', 'DE₁₆', 'ED₁₆', 'FE₁₆'],
    1,
    'Kelompokkan 1101 dan 1110; nilainya D dan E, sehingga DE₁₆.',
  ),
  Question(
    'K09',
    'Konversi',
    'Hasil konversi 17₈ ke heksadesimal adalah ...',
    ['0F₁₆', '0E₁₆', '11₁₆', '17₁₆'],
    0,
    '17₈ = 001 111₂ = 0000 1111₂ = 0F₁₆.',
  ),
  Question(
    'K10',
    'Konversi',
    'Metode yang tepat untuk mengubah desimal ke basis lain adalah ...',
    [
      'Pembagian berulang dan membaca sisa dari belakang',
      'Menjumlahkan semua digit tanpa memperhatikan posisi',
      'Mengalikan setiap digit dengan 10 saja',
      'Menghapus digit yang bernilai nol',
    ],
    0,
    'Konversi dari desimal ke basis lain dilakukan dengan pembagian berulang, lalu sisa dibaca dari belakang.',
  ),
];

const activities = [
  ActivityItem(
    'Latihan',
    'Menyelesaikan Latihan - Biner',
    'Skor 80%',
    'Hari ini • 10:24',
  ),
  ActivityItem('Materi', 'Membuka materi Biner', '', 'Hari ini • 10:10'),
  ActivityItem(
    'Challenge',
    'Menyelesaikan Challenge - Desimal',
    'Skor 70%',
    'Hari ini • 09:45',
  ),
  ActivityItem(
    'Materi',
    'Membuka materi Desimal',
    '',
    '16 September 2024 • 14:20',
  ),
];
