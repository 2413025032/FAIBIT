import 'dart:math';

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
        visualKind: MaterialVisualKind.decimalPlaceValue,
        additionalExamples: [
          '582 = 5 × 100 + 8 × 10 + 2 × 1 = 500 + 80 + 2.',
          '4.206 = 4 × 1.000 + 2 × 100 + 0 × 10 + 6 = 4.206.',
        ],
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
        additionalExamples: [
          '582 = 5 × 10² + 8 × 10¹ + 2 × 10⁰ = 500 + 80 + 2.',
          '731 = 7 × 10² + 3 × 10¹ + 1 × 10⁰ = 700 + 30 + 1.',
        ],
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
        additionalExamples: [
          '731 = 700 + 30 + 1.',
          '8.406 = 8.000 + 400 + 0 + 6.',
        ],
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
        visualKind: MaterialVisualKind.binaryPlaceValue,
        additionalExamples: [
          '1101₂ = 1 × 2³ + 1 × 2² + 0 × 2¹ + 1 × 2⁰ = 13₁₀.',
          '10010₂ = 16 + 0 + 0 + 2 + 0 = 18₁₀.',
        ],
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
        additionalExamples: [
          '1101₂ = 8 + 4 + 0 + 1 = 13₁₀.',
          '10110₂ = 16 + 0 + 4 + 2 + 0 = 22₁₀.',
        ],
      ),
      MaterialSection(
        title: 'Pola Bilangan Biner',
        content: '''
Perubahan nilai pada bilangan biner terjadi ketika digit 1 pada posisi tertentu tidak dapat bertambah lagi. Ketika semua posisi bernilai 1 dan ditambah satu, akan terbentuk posisi baru di sebelah kiri.
''',
        example: '''
0₂ → 1₂ → 10₂ → 11₂ → 100₂ → 101₂ → 110₂ → 111₂ → 1000₂
''',
        additionalExamples: [
          '1010₂ + 1₂ = 1011₂.',
          '1011₂ + 1₂ = 1100₂ karena terjadi perpindahan nilai pada beberapa bit.',
        ],
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
        additionalExamples: [
          '11110000₂ terdiri dari 8 bit atau 1 byte.',
          '1010101010101010₂ terdiri dari 16 bit.',
        ],
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
        visualKind: MaterialVisualKind.octalPlaceValue,
        additionalExamples: [
          'Pada 426₈, posisi dari kanan bernilai 8⁰, 8¹, dan 8².',
          '8³ = 512 dan 8⁴ = 4.096.',
        ],
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
        additionalExamples: [
          '326₈ = 3 × 8² + 2 × 8¹ + 6 × 8⁰ = 192 + 16 + 6 = 214₁₀.',
          '417₈ = 4 × 64 + 1 × 8 + 7 = 271₁₀.',
        ],
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
        visualKind: MaterialVisualKind.groupingThreeBits,
        additionalExamples: [
          '110 001₂ → 6 1 → 61₈.',
          '100 111₂ → 4 7 → 47₈.',
        ],
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
        visualKind: MaterialVisualKind.hexadecimalSymbols,
        additionalExamples: [
          'B₁₆ = 11₁₀, D₁₆ = 13₁₀, dan E₁₆ = 14₁₀.',
          '19₁₆ menggunakan digit 1 dan 9, sedangkan 1A₁₆ menggunakan digit 1 dan nilai A (10).',
        ],
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
        additionalExamples: [
          '16² = 256, sehingga digit pada posisi ketiga dari kanan bernilai kelipatan 256.',
          '2F₁₆ = 2 × 16¹ + 15 × 16⁰ = 32 + 15 = 47₁₀.',
        ],
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
        additionalExamples: [
          '4C₁₆ = 4 × 16 + 12 = 64 + 12 = 76₁₀.',
          '5A₁₆ = 5 × 16 + 10 = 80 + 10 = 90₁₀.',
        ],
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
        visualKind: MaterialVisualKind.groupingFourBits,
        additionalExamples: [
          '1100₂ = C₁₆ dan 1111₂ = F₁₆.',
          '1010 0111₂ = A7₁₆.',
        ],
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
        additionalExamples: [
          '31₁₀ = 11111₂ = 37₈ = 1F₁₆. Nilainya tetap sama, hanya bentuk penulisannya berbeda.',
          '16₁₀ = 10000₂ = 20₈ = 10₁₆.',
        ],
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
        visualKind: MaterialVisualKind.divisionByTwo,
        additionalExamples: [
          '19 ÷ 2 = 9 sisa 1; 9 ÷ 2 = 4 sisa 1; 4 ÷ 2 = 2 sisa 0; 2 ÷ 2 = 1 sisa 0; 1 ÷ 2 = 0 sisa 1. Hasil: 10011₂.',
          '34₁₀ = 100010₂. Baca sisa pembagian dari bawah ke atas.',
        ],
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
        additionalExamples: [
          '10010₂ = 1 × 16 + 0 × 8 + 0 × 4 + 1 × 2 + 0 × 1 = 18₁₀.',
          '11101₂ = 16 + 8 + 4 + 0 + 1 = 29₁₀.',
        ],
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
        visualKind: MaterialVisualKind.divisionByEight,
        additionalExamples: [
          '58 ÷ 8 = 7 sisa 2; 7 ÷ 8 = 0 sisa 7. Baca dari bawah: 72₈.',
          '73 ÷ 8 = 9 sisa 1; 9 ÷ 8 = 1 sisa 1; 1 ÷ 8 = 0 sisa 1. Hasil: 111₈.',
        ],
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
        additionalExamples: [
          '326₈ = 3 × 64 + 2 × 8 + 6 = 214₁₀.',
          '417₈ = 4 × 64 + 1 × 8 + 7 = 271₁₀.',
        ],
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
        visualKind: MaterialVisualKind.divisionBySixteen,
        additionalExamples: [
          '125 ÷ 16 = 7 sisa 13 (D); 7 ÷ 16 = 0 sisa 7. Hasil: 7D₁₆.',
          '90 ÷ 16 = 5 sisa 10 (A). Hasil: 5A₁₆.',
        ],
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
        additionalExamples: [
          '4C₁₆ = 4 × 16 + 12 = 76₁₀.',
          '5A₁₆ = 5 × 16 + 10 = 90₁₀.',
        ],
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
        visualKind: MaterialVisualKind.groupingThreeBits,
        additionalExamples: [
          '11010101₂ → 011 | 010 | 101 → 3 | 2 | 5 → 325₈.',
          '101011₂ → 101 | 011 → 5 | 3 → 53₈.',
        ],
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
        additionalExamples: [
          '46₈ → 4 = 100 dan 6 = 110 → 100110₂.',
          '25₈ → 2 = 010 dan 5 = 101 → 010101₂.',
        ],
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
        visualKind: MaterialVisualKind.groupingFourBits,
        additionalExamples: [
          '10111100₂ → 1011 | 1100 → B | C → BC₁₆.',
          '11101001₂ → 1110 | 1001 → E | 9 → E9₁₆.',
        ],
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
        additionalExamples: [
          '4C₁₆ → 4 = 0100 dan C = 1100 → 01001100₂.',
          'A7₁₆ → A = 1010 dan 7 = 0111 → 10100111₂.',
        ],
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
        additionalExamples: [
          '346₈ → 011 100 110₂ → 0000 1110 0110₂ → E6₁₆.',
        ],
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
        additionalExamples: [
          'A7₁₆ → 1010 0111₂ → 010 100 111₂ → 247₈.',
        ],
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


  // Tambahan soal Desimal (tingkat menengah dan penerapan).
  Question(
    'D11',
    'Desimal',
    'Pada bilangan 6.482₁₀, nilai digit 4 adalah ...',
    ['4', '40', '400', '4.000'],
    2,
    'Digit 4 berada pada posisi ratusan, sehingga nilainya 4 × 100 = 400.',
  ),
  Question(
    'D12',
    'Desimal',
    'Penguraian nilai tempat yang benar untuk 2.407₁₀ adalah ...',
    ['2×10³ + 4×10² + 0×10¹ + 7×10⁰', '2×10² + 4×10³ + 0×10¹ + 7×10⁰', '2×10³ + 4×10¹ + 7×10⁰', '2×10⁴ + 4×10² + 7×10¹'],
    0,
    'Dari kanan, posisi digit adalah 10⁰, 10¹, 10², dan 10³. Jadi 2.407 = 2×1.000 + 4×100 + 0×10 + 7.',
  ),
  Question(
    'D13',
    'Desimal',
    'Bilangan desimal yang muncul setelah 9.999₁₀ adalah ...',
    ['9.100', '10.000', '9.990', '10.009'],
    1,
    'Menambahkan satu pada 9.999 menghasilkan 10.000 karena terbentuk posisi puluh ribuan.',
  ),
  Question(
    'D14',
    'Desimal',
    'Bentuk bilangan dari 3.000 + 500 + 20 + 6 adalah ...',
    ['3.256', '3.520', '3.526', '3.562'],
    2,
    'Gabungkan nilai tempatnya: 3.000 + 500 + 20 + 6 = 3.526.',
  ),
  Question(
    'D15',
    'Desimal',
    'Pada bilangan 28.451₁₀, nilai digit 8 adalah ...',
    ['8', '80', '800', '8.000'],
    3,
    'Digit 8 menempati posisi ribuan, sehingga nilainya 8 × 1.000 = 8.000.',
  ),
  Question(
    'D16',
    'Desimal',
    'Penguraian yang tepat untuk 5.073₁₀ adalah ...',
    ['5×1.000 + 7×10 + 3', '5×100 + 7×10 + 3', '5×1.000 + 7×100 + 3', '5×10.000 + 7×10 + 3'],
    0,
    'Angka 5 berada di ribuan, 0 di ratusan, 7 di puluhan, dan 3 di satuan. Hasilnya 5.000 + 70 + 3.',
  ),
  Question(
    'D17',
    'Desimal',
    'Di antara bilangan berikut, manakah yang nilainya paling besar?',
    ['4.090', '4.009', '4.900', '4.099'],
    2,
    'Bandingkan dari nilai tempat terbesar. Bilangan 4.900 memiliki nilai ratusan terbesar, yaitu 9 ratusan.',
  ),
  Question(
    'D18',
    'Desimal',
    'Bentuk penguraian yang benar dari 4.708₁₀ adalah ...',
    ['4.000 + 700 + 80', '4.000 + 70 + 8', '4.000 + 700 + 8', '400 + 70 + 8'],
    2,
    '4.708 terdiri dari 4 ribuan, 7 ratusan, 0 puluhan, dan 8 satuan: 4.000 + 700 + 8.',
  ),
  Question(
    'D19',
    'Desimal',
    'Bilangan yang terdiri dari 8 ribuan, 3 ratusan, 0 puluhan, dan 5 satuan adalah ...',
    ['8.350', '8.305', '8.035', '8.503'],
    1,
    'Susun digit sesuai urutan ribuan, ratusan, puluhan, dan satuan: 8-3-0-5, sehingga menjadi 8.305.',
  ),
  Question(
    'D20',
    'Desimal',
    'Jika 5.678₁₀ ditambah 100, hasilnya adalah ...',
    ['5.688', '5.768', '5.778', '6.678'],
    2,
    'Menambahkan 100 berarti menambah satu pada posisi ratusan: 5.678 + 100 = 5.778.',
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


  // Tambahan soal Biner (tingkat menengah dan penerapan).
  Question(
    'B11',
    'Biner',
    'Nilai desimal dari (100101)₂ adalah ...',
    ['35', '36', '37', '38'],
    2,
    '100101₂ = 1×32 + 0×16 + 0×8 + 1×4 + 0×2 + 1 = 32 + 4 + 1 = 37₁₀.',
  ),
  Question(
    'B12',
    'Biner',
    'Berapa banyak bit yang terdapat pada bilangan 101101₂?',
    ['4 bit', '5 bit', '6 bit', '7 bit'],
    2,
    'Jumlah bit dihitung dari banyaknya digit biner. Bilangan 101101 memiliki enam digit.',
  ),
  Question(
    'B13',
    'Biner',
    'Hasil konversi (11001)₂ ke desimal adalah ...',
    ['23', '24', '25', '26'],
    2,
    '11001₂ = 1×16 + 1×8 + 0×4 + 0×2 + 1 = 16 + 8 + 1 = 25₁₀.',
  ),
  Question(
    'B14',
    'Biner',
    'Hitung hasil operasi 1011₂ + 1₂.',
    ['1010₂', '1100₂', '1110₂', '1000₂'],
    1,
    '1011₂ bernilai 11. Setelah ditambah 1 menjadi 12, yaitu 1100₂.',
  ),
  Question(
    'B15',
    'Biner',
    'Hasil penjumlahan biner 1011₂ + 10₂ adalah ...',
    ['1100₂', '1101₂', '1110₂', '10001₂'],
    1,
    '1011₂ = 11 dan 10₂ = 2. Jumlahnya 13₁₀, yaitu 1101₂.',
  ),
  Question(
    'B16',
    'Biner',
    'Bentuk biner dari 45₁₀ adalah ...',
    ['101011₂', '101101₂', '110101₂', '111001₂'],
    1,
    '45 = 32 + 8 + 4 + 1, sehingga bit dari 32 sampai 1 adalah 1-0-1-1-0-1 atau 101101₂.',
  ),
  Question(
    'B17',
    'Biner',
    'Bentuk biner dari 42₁₀ adalah ...',
    ['101010₂', '101001₂', '100110₂', '110010₂'],
    0,
    '42 = 32 + 8 + 2, sehingga representasi binernya 101010₂.',
  ),
  Question(
    'B18',
    'Biner',
    'Manakah bilangan biner yang memiliki nilai lebih besar?',
    ['10110₂', '10011₂', 'Keduanya sama', 'Tidak dapat ditentukan'],
    0,
    '10110₂ = 22₁₀, sedangkan 10011₂ = 19₁₀. Jadi 10110₂ lebih besar.',
  ),
  Question(
    'B19',
    'Biner',
    'Nilai desimal dari 00010110₂ adalah ...',
    ['18', '20', '22', '24'],
    2,
    'Nol di depan tidak mengubah nilai. 00010110₂ = 16 + 4 + 2 = 22₁₀.',
  ),
  Question(
    'B20',
    'Biner',
    'Hasil penjumlahan 101011₂ + 1₂ adalah ...',
    ['101010₂', '101100₂', '110000₂', '111011₂'],
    1,
    '101011₂ bernilai 43. Setelah ditambah 1 menjadi 44, yaitu 101100₂.',
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


  // Tambahan soal Oktal (tingkat menengah dan penerapan).
  Question(
    'O11',
    'Oktal',
    'Pilih satu bilangan yang hanya memakai digit 0 sampai 7.',
    ['408₈', '407₈', '789₈', '819₈'],
    1,
    'Bilangan oktal hanya menggunakan digit 0 sampai 7. Karena itu, 407₈ valid.',
  ),
  Question(
    'O12',
    'Oktal',
    'Pada bilangan 652₈, nilai digit 5 adalah ...',
    ['5', '8', '40', '320'],
    2,
    'Digit 5 berada pada posisi 8¹, sehingga nilainya 5 × 8 = 40.',
  ),
  Question(
    'O13',
    'Oktal',
    'Nilai desimal dari (34)₈ adalah ...',
    ['24', '26', '28', '30'],
    2,
    '34₈ = 3 × 8 + 4 = 24 + 4 = 28₁₀.',
  ),
  Question(
    'O14',
    'Oktal',
    'Bilangan (123)₈ jika diubah ke desimal menjadi ...',
    ['81', '82', '83', '84'],
    2,
    '123₈ = 1×64 + 2×8 + 3 = 64 + 16 + 3 = 83₁₀.',
  ),
  Question(
    'O15',
    'Oktal',
    'Nilai desimal dari (572)₈ adalah ...',
    ['370', '376', '378', '382'],
    2,
    '572₈ = 5×64 + 7×8 + 2 = 320 + 56 + 2 = 378₁₀.',
  ),
  Question(
    'O16',
    'Oktal',
    'Nilai desimal dari (706)₈ adalah ...',
    ['446', '452', '454', '456'],
    2,
    '706₈ = 7×64 + 0×8 + 6 = 448 + 6 = 454₁₀.',
  ),
  Question(
    'O17',
    'Oktal',
    'Hasil konversi 111001₂ ke oktal adalah ...',
    ['61₈', '70₈', '71₈', '73₈'],
    2,
    'Kelompokkan dari kanan: 111 | 001. Nilainya 7 dan 1, sehingga menjadi 71₈.',
  ),
  Question(
    'O18',
    'Oktal',
    'Bentuk biner dari 64₈ adalah ...',
    ['110010₂', '110100₂', '110110₂', '111000₂'],
    1,
    'Setiap digit oktal menjadi 3 bit: 6 = 110 dan 4 = 100. Hasilnya 110100₂.',
  ),
  Question(
    'O19',
    'Oktal',
    'Di antara bilangan berikut, manakah nilai oktalnya paling besar?',
    ['157₈', '146₈', '171₈', '162₈'],
    2,
    '171₈ = 1×64 + 7×8 + 1 = 121₁₀, lebih besar daripada pilihan lainnya.',
  ),
  Question(
    'O20',
    'Oktal',
    'Hasil penjumlahan (17)₈ + (25)₈ dalam bentuk oktal adalah ...',
    ['42₈', '43₈', '44₈', '45₈'],
    2,
    '17₈ = 15₁₀ dan 25₈ = 21₁₀. Jumlahnya 36₁₀, yaitu 44₈.',
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


  // Tambahan soal Heksadesimal (tingkat menengah dan penerapan).
  Question(
    'H11',
    'Heksadesimal',
    'Nilai desimal dari simbol C pada sistem heksadesimal adalah ...',
    ['11', '12', '13', '14'],
    1,
    'Urutan A sampai F mewakili 10 sampai 15, sehingga C bernilai 12.',
  ),
  Question(
    'H12',
    'Heksadesimal',
    'Dari pilihan berikut, kombinasi digit mana yang memenuhi aturan basis 16?',
    ['A9G₁₆', 'B7C₁₆', 'H21₁₆', 'Z10₁₆'],
    1,
    'Digit heksadesimal yang valid adalah 0–9 dan A–F. B7C₁₆ hanya menggunakan simbol yang valid.',
  ),
  Question(
    'H13',
    'Heksadesimal',
    'Nilai desimal dari (3E)₁₆ adalah ...',
    ['58', '60', '62', '64'],
    2,
    'E bernilai 14. Jadi 3E₁₆ = 3×16 + 14 = 48 + 14 = 62₁₀.',
  ),
  Question(
    'H14',
    'Heksadesimal',
    'Pada bilangan 5A₁₆, nilai digit 5 adalah ...',
    ['5', '16', '80', '90'],
    2,
    'Digit 5 berada pada posisi 16¹, sehingga nilainya 5 × 16 = 80.',
  ),
  Question(
    'H15',
    'Heksadesimal',
    'Nilai desimal dari (2F3)₁₆ adalah ...',
    ['739', '749', '755', '765'],
    2,
    '2F3₁₆ = 2×256 + 15×16 + 3 = 512 + 240 + 3 = 755₁₀.',
  ),
  Question(
    'H16',
    'Heksadesimal',
    'Nilai desimal dari (1C5)₁₆ adalah ...',
    ['437', '443', '453', '463'],
    2,
    'C bernilai 12. Jadi 1C5₁₆ = 1×256 + 12×16 + 5 = 256 + 192 + 5 = 453₁₀.',
  ),
  Question(
    'H17',
    'Heksadesimal',
    'Manakah bilangan heksadesimal yang nilainya lebih besar?',
    ['2A₁₆', '2F₁₆', 'Keduanya sama', 'Tidak dapat ditentukan'],
    1,
    'Keduanya memiliki digit pertama yang sama. Pada digit kedua, F (15) lebih besar daripada A (10), sehingga 2F₁₆ lebih besar.',
  ),
  Question(
    'H18',
    'Heksadesimal',
    'Kelompok biner 1101₂ setara dengan satu digit heksadesimal ...',
    ['B', 'C', 'D', 'E'],
    2,
    '1101₂ = 8 + 4 + 0 + 1 = 13₁₀. Nilai 13 ditulis D dalam heksadesimal.',
  ),
  Question(
    'H19',
    'Heksadesimal',
    'Nilai desimal dari FF₁₆ adalah ...',
    ['225', '240', '254', '255'],
    3,
    'F bernilai 15. FF₁₆ = 15×16 + 15 = 240 + 15 = 255₁₀.',
  ),
  Question(
    'H20',
    'Heksadesimal',
    'Bentuk biner 8 bit dari A6₁₆ adalah ...',
    ['10100110₂', '10100101₂', '10010110₂', '11000110₂'],
    0,
    'A = 1010 dan 6 = 0110. Gabungkan menjadi 10100110₂.',
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
  // Tambahan soal Konversi (tingkat menengah dan penerapan).
  Question(
    'K11',
    'Konversi',
    'Bentuk biner dari 18₁₀ adalah ...',
    ['10001₂', '10010₂', '10100₂', '11000₂'],
    1,
    '18 = 16 + 2, sehingga bentuk binernya 10010₂.',
  ),
  Question(
    'K12',
    'Konversi',
    'Bentuk oktal dari 44₁₀ adalah ...',
    ['52₈', '53₈', '54₈', '55₈'],
    2,
    '44 ÷ 8 = 5 sisa 4. Baca sisa dari bawah ke atas: 54₈.',
  ),
  Question(
    'K13',
    'Konversi',
    'Bentuk heksadesimal dari 75₁₀ adalah ...',
    ['4A₁₆', '4B₁₆', '4C₁₆', '5B₁₆'],
    1,
    '75 ÷ 16 = 4 sisa 11. Sisa 11 ditulis B, sehingga hasilnya 4B₁₆.',
  ),
  Question(
    'K14',
    'Konversi',
    'Hasil konversi 100110₂ ke oktal adalah ...',
    ['44₈', '45₈', '46₈', '47₈'],
    2,
    'Kelompokkan dari kanan: 100 | 110. Nilainya 4 dan 6, sehingga hasilnya 46₈.',
  ),
  Question(
    'K15',
    'Konversi',
    'Bentuk heksadesimal dari 10010110₂ adalah ...',
    ['86₁₆', '96₁₆', 'A6₁₆', 'B6₁₆'],
    1,
    'Kelompokkan menjadi 1001 | 0110. Nilai kelompoknya 9 dan 6, sehingga menjadi 96₁₆.',
  ),
  Question(
    'K16',
    'Konversi',
    'Nilai desimal dari (57)₈ adalah ...',
    ['45', '46', '47', '48'],
    2,
    '57₈ = 5×8 + 7 = 40 + 7 = 47₁₀.',
  ),
  Question(
    'K17',
    'Konversi',
    'Nilai desimal dari (3A)₁₆ adalah ...',
    ['56', '57', '58', '59'],
    2,
    'A bernilai 10. Jadi 3A₁₆ = 3×16 + 10 = 48 + 10 = 58₁₀.',
  ),
  Question(
    'K18',
    'Konversi',
    'Bentuk biner dari (32)₈ adalah ...',
    ['011010₂', '011100₂', '101010₂', '110010₂'],
    0,
    '3 = 011 dan 2 = 010. Gabungkan menjadi 011010₂; nol di depan boleh dihilangkan menjadi 11010₂.',
  ),
  Question(
    'K19',
    'Konversi',
    'Hasil konversi 11010110₂ ke oktal adalah ...',
    ['316₈', '326₈', '336₈', '346₈'],
    1,
    'Kelompokkan dari kanan: 011 | 010 | 110. Nilainya 3, 2, dan 6, sehingga 326₈.',
  ),
  Question(
    'K20',
    'Konversi',
    'Manakah kelompok bilangan yang memiliki nilai setara?',
    ['45₁₀ = 101101₂ = 54₈ = 2D₁₆', '45₁₀ = 101011₂ = 55₈ = 2D₁₆', '45₁₀ = 101101₂ = 55₈ = 2D₁₆', '45₁₀ = 101101₂ = 55₈ = 2B₁₆'],
    2,
    '45₁₀ = 32 + 8 + 4 + 1 = 101101₂; 45₁₀ = 5×8 + 5 = 55₈; dan 45₁₀ = 2×16 + 13 = 2D₁₆.',
  ),

];

// Bank soal khusus Challenge.
// Soal disusun berpasangan dengan indikator Latihan Santai pada materi yang sama,
// tetapi menggunakan angka, konteks, dan redaksi yang berbeda.
const challengeQuestionBank = [
  // ============================================================
  // CHALLENGE: DESIMAL
  // ============================================================
  Question(
    'CD01',
    'Desimal',
    'Berapakah basis yang digunakan dalam sistem bilangan desimal?',
    ['2', '8', '10', '16'],
    2,
    'Sistem desimal memiliki basis 10 karena menggunakan sepuluh simbol, yaitu 0 sampai 9.',
  ),
  Question(
    'CD02',
    'Desimal',
    'Manakah kumpulan simbol yang seluruhnya digunakan dalam sistem desimal?',
    ['0–7', '0–9', '1–10', '0–9 dan A–F'],
    1,
    'Sistem desimal menggunakan simbol 0, 1, 2, 3, 4, 5, 6, 7, 8, dan 9.',
  ),
  Question(
    'CD03',
    'Desimal',
    'Pada bilangan 684₁₀, digit 6 menempati nilai tempat ...',
    ['Satuan', 'Puluhan', 'Ratusan', 'Ribuan'],
    2,
    'Pada bilangan 684, digit 6 berada di posisi ratusan, sehingga nilainya 6 × 10² = 600.',
  ),
  Question(
    'CD04',
    'Desimal',
    'Nilai digit 5 pada bilangan 258₁₀ adalah ...',
    ['5', '50', '200', '500'],
    1,
    'Digit 5 berada pada posisi puluhan, sehingga nilainya 5 × 10 = 50.',
  ),
  Question(
    'CD05',
    'Desimal',
    'Penguraian nilai tempat yang tepat untuk 472₁₀ adalah ...',
    [
      '4×10² + 7×10¹ + 2×10⁰',
      '4×10¹ + 7×10² + 2×10⁰',
      '4×10² + 7×10⁰ + 2×10¹',
      '4×10³ + 7×10² + 2×10¹',
    ],
    0,
    'Dari kanan, nilai tempatnya adalah 10⁰, 10¹, dan 10². Jadi 472 = 4×100 + 7×10 + 2×1.',
  ),
  Question(
    'CD06',
    'Desimal',
    'Hasil dari 3×10² + 8×10¹ + 6×10⁰ adalah ...',
    ['368', '386', '836', '308'],
    1,
    'Hitung setiap nilai tempat: 3×100 + 8×10 + 6×1 = 300 + 80 + 6 = 386.',
  ),
  Question(
    'CD07',
    'Desimal',
    'Berapakah nilai digit 8 pada bilangan 806₁₀?',
    ['8', '80', '800', '806'],
    2,
    'Digit 8 berada pada posisi ratusan, sehingga nilainya 8 × 100 = 800.',
  ),
  Question(
    'CD08',
    'Desimal',
    'Pada bilangan 3.461₁₀, angka 4 berada pada posisi ...',
    ['Satuan', 'Puluhan', 'Ratusan', 'Ribuan'],
    2,
    'Urutan posisi dari kanan adalah satuan (1), puluhan (6), ratusan (4), dan ribuan (3).',
  ),
  Question(
    'CD09',
    'Desimal',
    'Bilangan yang tepat setelah 1.299₁₀ adalah ...',
    ['1.290', '1.300', '1.299', '1.309'],
    1,
    'Menambahkan satu pada 1.299 menghasilkan 1.300.',
  ),
  Question(
    'CD10',
    'Desimal',
    'Bentuk desimal dari 4×10³ + 2×10¹ + 9×10⁰ adalah ...',
    ['4.029', '4.209', '4.290', '40.029'],
    0,
    'Perhitungannya adalah 4.000 + 20 + 9 = 4.029.',
  ),

  // Tambahan Challenge Desimal (tingkat menengah dan penerapan).
  Question(
    'CD11',
    'Desimal',
    'Pada bilangan 7.359₁₀, nilai digit 3 adalah ...',
    ['3', '30', '300', '3.000'],
    2,
    'Digit 3 berada pada posisi ratusan, sehingga nilainya 3 × 100 = 300.',
  ),
  Question(
    'CD12',
    'Desimal',
    'Penguraian nilai tempat yang benar untuk 5.306₁₀ adalah ...',
    ['5×10³ + 3×10² + 0×10¹ + 6×10⁰', '5×10² + 3×10³ + 0×10¹ + 6×10⁰', '5×10³ + 3×10¹ + 6×10⁰', '5×10⁴ + 3×10² + 6×10¹'],
    0,
    'Dari kanan, posisi digit adalah 10⁰, 10¹, 10², dan 10³. Jadi 5.306 = 5×1.000 + 3×100 + 0×10 + 6.',
  ),
  Question(
    'CD13',
    'Desimal',
    'Bilangan desimal yang muncul setelah 4.999₁₀ adalah ...',
    ['4.990', '5.000', '5.009', '4.100'],
    1,
    'Menambahkan satu pada 4.999 menghasilkan 5.000 karena terjadi perpindahan ke posisi ribuan berikutnya.',
  ),
  Question(
    'CD14',
    'Desimal',
    'Bentuk bilangan dari 6.000 + 200 + 40 + 8 adalah ...',
    ['6.248', '6.284', '6.428', '6.204'],
    0,
    'Gabungkan nilai tempatnya: 6.000 + 200 + 40 + 8 = 6.248.',
  ),
  Question(
    'CD15',
    'Desimal',
    'Pada bilangan 36.824₁₀, nilai digit 6 adalah ...',
    ['6', '60', '600', '6.000'],
    3,
    'Digit 6 menempati posisi ribuan, sehingga nilainya 6 × 1.000 = 6.000.',
  ),
  Question(
    'CD16',
    'Desimal',
    'Penguraian yang tepat untuk 8.042₁₀ adalah ...',
    ['8×1.000 + 4×10 + 2', '8×100 + 4×10 + 2', '8×1.000 + 4×100 + 2', '8×10.000 + 4×10 + 2'],
    0,
    'Angka 8 berada di ribuan, 0 di ratusan, 4 di puluhan, dan 2 di satuan. Hasilnya 8.000 + 40 + 2.',
  ),
  Question(
    'CD17',
    'Desimal',
    'Pilih bilangan desimal terbesar dari daftar berikut.',
    ['7.080', '7.008', '7.800', '7.088'],
    2,
    'Bilangan 7.800 memiliki nilai ratusan terbesar, yaitu 8 ratusan.',
  ),
  Question(
    'CD18',
    'Desimal',
    'Bentuk penguraian yang benar dari 6.509₁₀ adalah ...',
    ['6.000 + 50 + 9', '6.000 + 500 + 9', '600 + 500 + 9', '6.000 + 500 + 90'],
    1,
    '6.509 terdiri dari 6 ribuan, 5 ratusan, 0 puluhan, dan 9 satuan: 6.000 + 500 + 9.',
  ),
  Question(
    'CD19',
    'Desimal',
    'Bilangan yang terdiri dari 4 ribuan, 7 ratusan, 0 puluhan, dan 2 satuan adalah ...',
    ['4.720', '4.702', '4.072', '4.207'],
    1,
    'Susun digit sesuai urutan ribuan, ratusan, puluhan, dan satuan: 4-7-0-2, sehingga menjadi 4.702.',
  ),
  Question(
    'CD20',
    'Desimal',
    'Jika 8.245₁₀ ditambah 100, hasilnya adalah ...',
    ['8.255', '8.345', '8.445', '9.245'],
    1,
    'Menambahkan 100 berarti menambah satu pada posisi ratusan: 8.245 + 100 = 8.345.',
  ),

  // ============================================================
  // CHALLENGE: BINER
  // ============================================================
  Question(
    'CB01',
    'Biner',
    'Sistem bilangan biner menggunakan berapa simbol dasar?',
    ['1', '2', '8', '10'],
    1,
    'Biner menggunakan dua simbol dasar, yaitu 0 dan 1.',
  ),
  Question(
    'CB02',
    'Biner',
    'Pasangan digit yang dapat digunakan untuk membentuk bilangan biner adalah ...',
    ['0 dan 1', '0 dan 2', '1 dan 2', '0 dan 9'],
    0,
    'Digit yang valid pada sistem biner hanya 0 dan 1.',
  ),
  Question(
    'CB03',
    'Biner',
    '(1101)₂ jika diubah ke desimal bernilai ...',
    ['11', '12', '13', '14'],
    2,
    '1101₂ = 1×8 + 1×4 + 0×2 + 1×1 = 13₁₀.',
  ),
  Question(
    'CB04',
    'Biner',
    'Nilai desimal dari (10110)₂ adalah ...',
    ['20', '21', '22', '23'],
    2,
    '10110₂ = 16 + 0 + 4 + 2 + 0 = 22₁₀.',
  ),
  Question(
    'CB05',
    'Biner',
    'Hasil konversi (100101)₂ ke desimal adalah ...',
    ['35', '36', '37', '38'],
    2,
    '100101₂ = 32 + 0 + 0 + 4 + 0 + 1 = 37₁₀.',
  ),
  Question(
    'CB06',
    'Biner',
    '(10111)₂ memiliki nilai desimal ...',
    ['21', '22', '23', '24'],
    2,
    '10111₂ = 16 + 0 + 4 + 2 + 1 = 23₁₀.',
  ),
  Question(
    'CB07',
    'Biner',
    'Bilangan 11101₂ tersusun atas ... bit.',
    ['4', '5', '6', '7'],
    1,
    'Jumlah bit dihitung dari banyaknya digit biner. Bilangan 11101 memiliki lima digit.',
  ),
  Question(
    'CB08',
    'Biner',
    'Berapa banyak bit yang terdapat pada bilangan 10110010₂?',
    ['6 bit', '7 bit', '8 bit', '9 bit'],
    2,
    'Bilangan 10110010 terdiri dari delapan digit biner, sehingga panjangnya 8 bit.',
  ),
  Question(
    'CB09',
    'Biner',
    'Sekumpulan delapan bit disebut ...',
    ['Word', 'Byte', 'Nibble', 'Digit'],
    1,
    'Delapan bit membentuk satu byte.',
  ),
  Question(
    'CB10',
    'Biner',
    'Jika 1 ditambahkan pada 1011₂, hasilnya adalah ...',
    ['1010₂', '1100₂', '1110₂', '10000₂'],
    1,
    '1011₂ bernilai 11 desimal. Setelah ditambah 1 menjadi 12 desimal, yaitu 1100₂.',
  ),

  // Tambahan Challenge Biner (tingkat menengah dan penerapan).
  Question(
    'CB11',
    'Biner',
    'Nilai desimal dari (101101)₂ adalah ...',
    ['43', '44', '45', '46'],
    2,
    '101101₂ = 1×32 + 0×16 + 1×8 + 1×4 + 0×2 + 1 = 32 + 8 + 4 + 1 = 45₁₀.',
  ),
  Question(
    'CB12',
    'Biner',
    'Berapa banyak bit yang terdapat pada bilangan 1101011₂?',
    ['5 bit', '6 bit', '7 bit', '8 bit'],
    2,
    'Jumlah bit dihitung dari banyaknya digit biner. Bilangan 1101011 memiliki tujuh digit.',
  ),
  Question(
    'CB13',
    'Biner',
    'Hasil konversi (10111)₂ ke desimal adalah ...',
    ['21', '22', '23', '24'],
    2,
    '10111₂ = 1×16 + 0×8 + 1×4 + 1×2 + 1 = 16 + 4 + 2 + 1 = 23₁₀.',
  ),
  Question(
    'CB14',
    'Biner',
    'Hitung hasil setelah bilangan 1101₂ ditambah 1₂.',
    ['1100₂', '1110₂', '1111₂', '10000₂'],
    1,
    '1101₂ bernilai 13. Setelah ditambah 1 menjadi 14, yaitu 1110₂.',
  ),
  Question(
    'CB15',
    'Biner',
    'Hasil penjumlahan biner 1101₂ + 11₂ adalah ...',
    ['1110₂', '1111₂', '10000₂', '10001₂'],
    2,
    '1101₂ = 13 dan 11₂ = 3. Jumlahnya 16₁₀, yaitu 10000₂.',
  ),
  Question(
    'CB16',
    'Biner',
    'Bentuk biner dari 53₁₀ adalah ...',
    ['110011₂', '110101₂', '111001₂', '101101₂'],
    1,
    '53 = 32 + 16 + 4 + 1, sehingga bentuk binernya 110101₂.',
  ),
  Question(
    'CB17',
    'Biner',
    'Bentuk biner dari 38₁₀ adalah ...',
    ['100110₂', '101010₂', '100101₂', '110010₂'],
    0,
    '38 = 32 + 4 + 2, sehingga representasi binernya 100110₂.',
  ),
  Question(
    'CB18',
    'Biner',
    'Perhatikan 11001₂ dan 10111₂. Bilangan dengan nilai lebih tinggi adalah ...',
    ['11001₂', '10111₂', 'Keduanya sama', 'Tidak dapat ditentukan'],
    0,
    '11001₂ = 25₁₀, sedangkan 10111₂ = 23₁₀. Jadi 11001₂ lebih besar.',
  ),
  Question(
    'CB19',
    'Biner',
    'Nilai desimal dari 00011001₂ adalah ...',
    ['21', '23', '24', '25'],
    3,
    'Nol di depan tidak mengubah nilai. 00011001₂ = 16 + 8 + 1 = 25₁₀.',
  ),
  Question(
    'CB20',
    'Biner',
    'Hasil penjumlahan 110011₂ + 1₂ adalah ...',
    ['110010₂', '110100₂', '111000₂', '111011₂'],
    1,
    '110011₂ bernilai 51. Setelah ditambah 1 menjadi 52, yaitu 110100₂.',
  ),

  // ============================================================
  // CHALLENGE: OKTAL
  // ============================================================
  Question(
    'CO01',
    'Oktal',
    'Sistem bilangan oktal memiliki basis ...',
    ['2', '8', '10', '16'],
    1,
    'Sistem bilangan oktal menggunakan basis 8.',
  ),
  Question(
    'CO02',
    'Oktal',
    'Rentang digit yang diperbolehkan pada bilangan oktal adalah ...',
    ['0–7', '1–8', '0–8', '0–9'],
    0,
    'Bilangan oktal hanya menggunakan delapan simbol, yaitu 0 sampai 7.',
  ),
  Question(
    'CO03',
    'Oktal',
    'Manakah bilangan berikut yang valid dalam sistem oktal?',
    ['128₈', '709₈', '624₈', '890₈'],
    2,
    '624₈ valid karena seluruh digitnya berada pada rentang 0 sampai 7. Angka 8 dan 9 tidak boleh digunakan.',
  ),
  Question(
    'CO04',
    'Oktal',
    'Pada bilangan 735₈, nilai digit 3 adalah ...',
    ['3', '24', '30', '192'],
    1,
    'Digit 3 berada pada posisi 8¹, sehingga nilainya 3 × 8 = 24.',
  ),
  Question(
    'CO05',
    'Oktal',
    'Nilai desimal dari (25)₈ adalah ...',
    ['17', '19', '21', '23'],
    2,
    '25₈ = 2×8¹ + 5×8⁰ = 16 + 5 = 21₁₀.',
  ),
  Question(
    'CO06',
    'Oktal',
    '(315)₈ sama dengan bilangan desimal ...',
    ['197', '205', '213', '225'],
    1,
    '315₈ = 3×64 + 1×8 + 5 = 192 + 8 + 5 = 205₁₀.',
  ),
  Question(
    'CO07',
    'Oktal',
    'Penguraian yang benar untuk (426)₈ adalah ...',
    [
      '4×8² + 2×8¹ + 6×8⁰',
      '4×8¹ + 2×8² + 6×8⁰',
      '4×8⁰ + 2×8¹ + 6×8²',
      '4×10² + 2×10¹ + 6×10⁰',
    ],
    0,
    'Posisi paling kanan menggunakan 8⁰, posisi tengah 8¹, dan posisi kiri 8².',
  ),
  Question(
    'CO08',
    'Oktal',
    'Satu digit pada sistem oktal dapat diwakili oleh ... bit biner.',
    ['2 bit', '3 bit', '4 bit', '8 bit'],
    1,
    'Karena 2³ = 8, satu digit oktal setara dengan tiga bit biner.',
  ),
  Question(
    'CO09',
    'Oktal',
    'Digit terbesar yang dapat digunakan dalam sistem bilangan oktal adalah ...',
    ['6', '7', '8', '9'],
    1,
    'Digit oktal dimulai dari 0 sampai 7, sehingga digit terbesarnya adalah 7.',
  ),
  Question(
    'CO10',
    'Oktal',
    'Hasil konversi (46)₈ ke desimal adalah ...',
    ['34', '36', '38', '40'],
    2,
    '46₈ = 4×8 + 6 = 32 + 6 = 38₁₀.',
  ),

  // Tambahan Challenge Oktal (tingkat menengah dan penerapan).
  Question(
    'CO11',
    'Oktal',
    'Angka manakah yang hanya memuat digit valid untuk basis 8?',
    ['628₈', '625₈', '819₈', '908₈'],
    1,
    'Bilangan oktal hanya menggunakan digit 0 sampai 7. Karena itu, 625₈ valid.',
  ),
  Question(
    'CO12',
    'Oktal',
    'Pada bilangan 437₈, nilai digit 3 adalah ...',
    ['3', '8', '24', '192'],
    2,
    'Digit 3 berada pada posisi 8¹, sehingga nilainya 3 × 8 = 24.',
  ),
  Question(
    'CO13',
    'Oktal',
    'Nilai desimal dari (46)₈ adalah ...',
    ['34', '36', '38', '40'],
    2,
    '46₈ = 4 × 8 + 6 = 32 + 6 = 38₁₀.',
  ),
  Question(
    'CO14',
    'Oktal',
    'Bilangan (215)₈ jika diubah ke desimal menjadi ...',
    ['139', '140', '141', '142'],
    2,
    '215₈ = 2×64 + 1×8 + 5 = 128 + 8 + 5 = 141₁₀.',
  ),
  Question(
    'CO15',
    'Oktal',
    'Nilai desimal dari (631)₈ adalah ...',
    ['401', '407', '409', '413'],
    2,
    '631₈ = 6×64 + 3×8 + 1 = 384 + 24 + 1 = 409₁₀.',
  ),
  Question(
    'CO16',
    'Oktal',
    'Nilai desimal dari (345)₈ adalah ...',
    ['221', '227', '229', '233'],
    2,
    '345₈ = 3×64 + 4×8 + 5 = 192 + 32 + 5 = 229₁₀.',
  ),
  Question(
    'CO17',
    'Oktal',
    'Hasil konversi 101110₂ ke oktal adalah ...',
    ['54₈', '55₈', '56₈', '57₈'],
    2,
    'Kelompokkan dari kanan: 101 | 110. Nilainya 5 dan 6, sehingga menjadi 56₈.',
  ),
  Question(
    'CO18',
    'Oktal',
    'Bentuk biner dari 53₈ adalah ...',
    ['100011₂', '101011₂', '101101₂', '110011₂'],
    1,
    'Setiap digit oktal menjadi 3 bit: 5 = 101 dan 3 = 011. Gabungkan menjadi 101011₂.',
  ),
  Question(
    'CO19',
    'Oktal',
    'Bilangan oktal yang mewakili nilai desimal paling besar adalah ...',
    ['234₈', '226₈', '217₈', '231₈'],
    0,
    '234₈ = 2×64 + 3×8 + 4 = 156₁₀, lebih besar daripada pilihan lainnya.',
  ),
  Question(
    'CO20',
    'Oktal',
    'Hasil penjumlahan (26)₈ + (17)₈ dalam bentuk oktal adalah ...',
    ['43₈', '44₈', '45₈', '46₈'],
    2,
    '26₈ = 22₁₀ dan 17₈ = 15₁₀. Jumlahnya 37₁₀, yaitu 45₈.',
  ),

  // ============================================================
  // CHALLENGE: HEKSADESIMAL
  // ============================================================
  Question(
    'CH01',
    'Heksadesimal',
    'Sistem heksadesimal dapat merepresentasikan berapa simbol berbeda dalam satu digit?',
    ['2', '8', '10', '16'],
    3,
    'Sistem heksadesimal menggunakan basis 16.',
  ),
  Question(
    'CH02',
    'Heksadesimal',
    'Kombinasi simbol yang digunakan dalam sistem heksadesimal adalah ...',
    ['0–7', '0–9 saja', '0–9 dan A–F', 'A–Z'],
    2,
    'Heksadesimal menggunakan angka 0 sampai 9 serta huruf A sampai F.',
  ),
  Question(
    'CH03',
    'Heksadesimal',
    'Simbol B pada bilangan heksadesimal mewakili nilai desimal ...',
    ['10', '11', '12', '13'],
    1,
    'Urutan A sampai F mewakili nilai 10 sampai 15. Dengan demikian, B bernilai 11.',
  ),
  Question(
    'CH04',
    'Heksadesimal',
    'Nilai desimal dari simbol E dalam sistem heksadesimal adalah ...',
    ['12', '13', '14', '15'],
    2,
    'A bernilai 10, B bernilai 11, C bernilai 12, D bernilai 13, dan E bernilai 14.',
  ),
  Question(
    'CH05',
    'Heksadesimal',
    'Pada bilangan 3C₁₆, nilai digit 3 adalah ...',
    ['3', '16', '48', '60'],
    2,
    'Digit 3 berada pada posisi 16¹, sehingga nilainya 3 × 16 = 48.',
  ),
  Question(
    'CH06',
    'Heksadesimal',
    'Nilai desimal dari (2B)₁₆ adalah ...',
    ['41', '42', '43', '44'],
    2,
    '2B₁₆ = 2×16 + 11 = 32 + 11 = 43₁₀.',
  ),
  Question(
    'CH07',
    'Heksadesimal',
    '(4D)₁₆ jika diubah ke desimal menjadi ...',
    ['61', '72', '77', '81'],
    2,
    'D bernilai 13, sehingga 4D₁₆ = 4×16 + 13 = 64 + 13 = 77₁₀.',
  ),
  Question(
    'CH08',
    'Heksadesimal',
    'Penguraian yang benar untuk (5A)₁₆ adalah ...',
    [
      '5×16¹ + 10×16⁰',
      '5×16⁰ + 10×16¹',
      '5×10¹ + 10×10⁰',
      '5×16² + 10×16¹',
    ],
    0,
    'Digit A bernilai 10 dan berada pada posisi 16⁰, sedangkan digit 5 berada pada posisi 16¹.',
  ),
  Question(
    'CH09',
    'Heksadesimal',
    'Berapa posisi bit yang diperlukan untuk menuliskan satu digit heksadesimal dalam bentuk biner?',
    ['2 bit', '3 bit', '4 bit', '8 bit'],
    2,
    'Karena 2⁴ = 16, satu digit heksadesimal dapat diwakili oleh empat bit biner.',
  ),
  Question(
    'CH10',
    'Heksadesimal',
    'Manakah penulisan bilangan heksadesimal yang valid?',
    ['B7₁₆', 'G1₁₆', '2H₁₆', 'Z0₁₆'],
    0,
    'Simbol yang valid hanya 0–9 dan A–F. Karena itu, B7₁₆ merupakan bilangan heksadesimal yang valid.',
  ),

  // Tambahan Challenge Heksadesimal (tingkat menengah dan penerapan).
  Question(
    'CH11',
    'Heksadesimal',
    'Nilai desimal dari simbol D pada sistem heksadesimal adalah ...',
    ['11', '12', '13', '14'],
    2,
    'Urutan A sampai F mewakili 10 sampai 15, sehingga D bernilai 13.',
  ),
  Question(
    'CH12',
    'Heksadesimal',
    'Pilih satu penulisan yang sah pada sistem bilangan basis 16.',
    ['C4G₁₆', 'J10₁₆', '4F2₁₆', 'C4H₁₆'],
    2,
    'Digit heksadesimal yang valid adalah 0–9 dan A–F. 4F2₁₆ hanya menggunakan simbol yang valid.',
  ),
  Question(
    'CH13',
    'Heksadesimal',
    'Nilai desimal dari (4B)₁₆ adalah ...',
    ['69', '73', '75', '79'],
    2,
    'B bernilai 11. Jadi 4B₁₆ = 4×16 + 11 = 64 + 11 = 75₁₀.',
  ),
  Question(
    'CH14',
    'Heksadesimal',
    'Pada bilangan 6D₁₆, nilai digit 6 adalah ...',
    ['6', '16', '96', '104'],
    2,
    'Digit 6 berada pada posisi 16¹, sehingga nilainya 6 × 16 = 96.',
  ),
  Question(
    'CH15',
    'Heksadesimal',
    'Nilai desimal dari (3A4)₁₆ adalah ...',
    ['912', '922', '932', '942'],
    2,
    '3A4₁₆ = 3×256 + 10×16 + 4 = 768 + 160 + 4 = 932₁₀.',
  ),
  Question(
    'CH16',
    'Heksadesimal',
    'Nilai desimal dari (2B7)₁₆ adalah ...',
    ['685', '695', '705', '715'],
    1,
    'B bernilai 11. Jadi 2B7₁₆ = 2×256 + 11×16 + 7 = 512 + 176 + 7 = 695₁₀.',
  ),
  Question(
    'CH17',
    'Heksadesimal',
    'Bandingkan 3A₁₆ dengan 3B₁₆. Bilangan yang lebih besar adalah ...',
    ['3A₁₆', '3B₁₆', 'Keduanya sama', 'Tidak dapat ditentukan'],
    1,
    'Digit pertama sama-sama 3. Pada digit kedua, B (11) lebih besar daripada A (10), sehingga 3B₁₆ lebih besar.',
  ),
  Question(
    'CH18',
    'Heksadesimal',
    'Kelompok biner 1010₂ setara dengan satu digit heksadesimal ...',
    ['9', 'A', 'B', 'C'],
    1,
    '1010₂ = 8 + 2 = 10₁₀. Nilai 10 ditulis A dalam heksadesimal.',
  ),
  Question(
    'CH19',
    'Heksadesimal',
    'Nilai desimal dari B6₁₆ adalah ...',
    ['176', '180', '182', '186'],
    2,
    'B bernilai 11. B6₁₆ = 11×16 + 6 = 176 + 6 = 182₁₀.',
  ),
  Question(
    'CH20',
    'Heksadesimal',
    'Konversikan B3₁₆ ke bentuk biner 8 bit.',
    ['10110011₂', '10110101₂', '10100011₂', '11110011₂'],
    0,
    'B = 1011 dan 3 = 0011. Gabungkan menjadi 10110011₂.',
  ),

  // ============================================================
  // CHALLENGE: KONVERSI
  // ============================================================
  Question(
    'CK01',
    'Konversi',
    'Bentuk biner dari 14₁₀ adalah ...',
    ['1010₂', '1100₂', '1110₂', '1001₂'],
    2,
    '14 = 8 + 4 + 2, sehingga digit binernya adalah 1110₂.',
  ),
  Question(
    'CK02',
    'Konversi',
    'Bilangan 19₁₀ jika dikonversi ke biner menjadi ...',
    ['10001₂', '10010₂', '10011₂', '10101₂'],
    2,
    '19 = 16 + 2 + 1, sehingga representasi binernya adalah 10011₂.',
  ),
  Question(
    'CK03',
    'Konversi',
    'Hasil konversi 34₁₀ ke sistem oktal adalah ...',
    ['40₈', '41₈', '42₈', '43₈'],
    2,
    '34 ÷ 8 = 4 sisa 2. Baca sisa dari bawah ke atas, hasilnya 42₈.',
  ),
  Question(
    'CK04',
    'Konversi',
    'Bentuk heksadesimal dari 58₁₀ adalah ...',
    ['3A₁₆', '3B₁₆', '4A₁₆', 'A3₁₆'],
    0,
    '58 ÷ 16 = 3 sisa 10. Sisa 10 ditulis A, sehingga hasilnya 3A₁₆.',
  ),
  Question(
    'CK05',
    'Konversi',
    'Hasil konversi 101₂ ke oktal adalah ...',
    ['3₈', '4₈', '5₈', '6₈'],
    2,
    'Kelompok 101₂ bernilai 5, sehingga 101₂ = 5₈.',
  ),
  Question(
    'CK06',
    'Konversi',
    'Bilangan 111010₂ jika diubah ke oktal menjadi ...',
    ['62₈', '71₈', '72₈', '73₈'],
    2,
    'Kelompokkan dari kanan: 111 | 010. Nilainya 7 dan 2, sehingga hasilnya 72₈.',
  ),
  Question(
    'CK07',
    'Konversi',
    'Hasil konversi 1100₂ ke heksadesimal adalah ...',
    ['A₁₆', 'B₁₆', 'C₁₆', 'D₁₆'],
    2,
    '1100₂ bernilai 12 desimal. Nilai 12 ditulis C dalam heksadesimal.',
  ),
  Question(
    'CK08',
    'Konversi',
    'Bentuk heksadesimal dari 10111100₂ adalah ...',
    ['AB₁₆', 'BC₁₆', 'CB₁₆', 'CD₁₆'],
    1,
    'Kelompokkan menjadi 1011 | 1100. Nilai kelompok tersebut adalah B dan C, sehingga hasilnya BC₁₆.',
  ),
  Question(
    'CK09',
    'Konversi',
    'Bilangan (25)₈ jika diubah ke heksadesimal menjadi ...',
    ['15₁₆', '19₁₆', '20₁₆', '21₁₆'],
    0,
    '25₈ = 2×8 + 5 = 21₁₀. Nilai 21 desimal sama dengan 15₁₆.',
  ),
  Question(
    'CK10',
    'Konversi',
    'Dalam metode pembagian berulang untuk mengubah desimal ke basis lain, sisa pembagian dibaca ...',
    [
      'Dari atas ke bawah',
      'Dari bawah ke atas',
      'Dari hasil bagi terbesar saja',
      'Secara acak',
    ],
    1,
    'Setelah pembagian berulang selesai, susun sisa pembagian mulai dari sisa terakhir hingga sisa pertama (dari bawah ke atas).',
  ),
  // Tambahan Challenge Konversi (tingkat menengah dan penerapan).
  Question(
    'CK11',
    'Konversi',
    'Bentuk biner dari 22₁₀ adalah ...',
    ['10100₂', '10110₂', '11000₂', '11100₂'],
    1,
    '22 = 16 + 4 + 2, sehingga bentuk binernya 10110₂.',
  ),
  Question(
    'CK12',
    'Konversi',
    'Bentuk oktal dari 53₁₀ adalah ...',
    ['63₈', '64₈', '65₈', '66₈'],
    2,
    '53 ÷ 8 = 6 sisa 5. Baca sisa dari bawah ke atas: 65₈.',
  ),
  Question(
    'CK13',
    'Konversi',
    'Bentuk heksadesimal dari 91₁₀ adalah ...',
    ['59₁₆', '5A₁₆', '5B₁₆', '5C₁₆'],
    2,
    '91 ÷ 16 = 5 sisa 11. Sisa 11 ditulis B, sehingga hasilnya 5B₁₆.',
  ),
  Question(
    'CK14',
    'Konversi',
    'Hasil konversi 111101₂ ke oktal adalah ...',
    ['73₈', '74₈', '75₈', '76₈'],
    2,
    'Kelompokkan dari kanan: 111 | 101. Nilainya 7 dan 5, sehingga hasilnya 75₈.',
  ),
  Question(
    'CK15',
    'Konversi',
    'Bentuk heksadesimal dari 11011011₂ adalah ...',
    ['DA₁₆', 'DB₁₆', 'DC₁₆', 'EB₁₆'],
    1,
    'Kelompokkan menjadi 1101 | 1011. Nilai kelompoknya D dan B, sehingga menjadi DB₁₆.',
  ),
  Question(
    'CK16',
    'Konversi',
    'Nilai desimal dari (64)₈ adalah ...',
    ['48', '50', '52', '54'],
    2,
    '64₈ = 6×8 + 4 = 48 + 4 = 52₁₀.',
  ),
  Question(
    'CK17',
    'Konversi',
    'Nilai desimal dari (4C)₁₆ adalah ...',
    ['72', '74', '76', '78'],
    2,
    'C bernilai 12. Jadi 4C₁₆ = 4×16 + 12 = 64 + 12 = 76₁₀.',
  ),
  Question(
    'CK18',
    'Konversi',
    'Bentuk biner dari (45)₈ adalah ...',
    ['100101₂', '100110₂', '101001₂', '101101₂'],
    0,
    '4 = 100 dan 5 = 101. Gabungkan menjadi 100101₂.',
  ),
  Question(
    'CK19',
    'Konversi',
    'Hasil konversi 10111011₂ ke oktal adalah ...',
    ['263₈', '273₈', '275₈', '303₈'],
    1,
    'Kelompokkan dari kanan: 010 | 111 | 011. Nilainya 2, 7, dan 3, sehingga 273₈.',
  ),
  Question(
    'CK20',
    'Konversi',
    'Pilih baris yang seluruh bilangan di dalamnya memiliki nilai setara.',
    ['58₁₀ = 111010₂ = 71₈ = 3A₁₆', '58₁₀ = 111001₂ = 72₈ = 3A₁₆', '58₁₀ = 111010₂ = 72₈ = 3A₁₆', '58₁₀ = 111010₂ = 72₈ = 3B₁₆'],
    2,
    '58₁₀ = 32 + 16 + 8 + 2 = 111010₂; 58₁₀ = 7×8 + 2 = 72₈; dan 58₁₀ = 3×16 + 10 = 3A₁₆.',
  ),

];


/// Jumlah soal yang ditampilkan dalam satu sesi Latihan Santai atau Challenge.
const int quizSessionQuestionCount = 10;

/// Mengelompokkan tingkat soal berdasarkan nomor pada ID.
/// ID 01-06 = dasar, 07-14 = menengah, 15-20 = penerapan.
/// Pola ini dipakai sama pada bank Latihan dan Challenge.
int questionDifficultyLevel(Question question) {
  final match = RegExp(r'(\d+)$').firstMatch(question.id);
  final sequence = int.tryParse(match?.group(1) ?? '');
  if (sequence == null || sequence < 1 || sequence > 20) {
    throw ArgumentError('ID soal tidak mengikuti pola tingkat: ${question.id}');
  }
  if (sequence <= 6) return 1;
  if (sequence <= 14) return 2;
  return 3;
}

List<Question> _takeRandomQuestions(
  List<Question> pool,
  int count,
  Random random,
) {
  if (pool.length < count) {
    throw StateError(
      'Bank soal tidak cukup: membutuhkan $count soal, tersedia ${pool.length}.',
    );
  }
  final shuffled = List<Question>.of(pool)..shuffle(random);
  return shuffled.take(count).toList(growable: false);
}

/// Memilih satu set soal untuk satu sesi.
/// Untuk satu materi, komposisinya 3 dasar, 4 menengah, dan 3 penerapan.
/// Untuk Semua Materi, dipilih 2 soal per materi agar cakupan merata.
/// Panggil fungsi ini sekali ketika sesi dimulai, lalu simpan hasilnya.
List<Question> selectQuestionsForSession({
  required List<Question> bank,
  required String materialTitle,
  Random? random,
}) {
  final rng = random ?? Random();
  final selected = <Question>[];

  if (materialTitle == 'Semua Materi') {
    for (final material in materials) {
      final pool = bank
          .where((question) => question.material == material.title)
          .toList(growable: false);
      final basic = pool.where((q) => questionDifficultyLevel(q) == 1).toList();
      final otherLevels = pool.where((q) => questionDifficultyLevel(q) != 1).toList();
      selected.addAll(_takeRandomQuestions(basic, 1, rng));
      selected.addAll(_takeRandomQuestions(otherLevels, 1, rng));
    }
  } else {
    final pool = bank
        .where((question) => question.material == materialTitle)
        .toList(growable: false);
    final basic = pool.where((q) => questionDifficultyLevel(q) == 1).toList();
    final intermediate = pool.where((q) => questionDifficultyLevel(q) == 2).toList();
    final application = pool.where((q) => questionDifficultyLevel(q) == 3).toList();

    selected
      ..addAll(_takeRandomQuestions(basic, 3, rng))
      ..addAll(_takeRandomQuestions(intermediate, 4, rng))
      ..addAll(_takeRandomQuestions(application, 3, rng));
  }

  selected.shuffle(rng);
  if (selected.length != quizSessionQuestionCount ||
      selected.map((question) => question.id).toSet().length != selected.length) {
    throw StateError('Pemilihan soal sesi tidak menghasilkan 10 soal unik.');
  }
  return List<Question>.unmodifiable(selected);
}

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
