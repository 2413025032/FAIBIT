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
