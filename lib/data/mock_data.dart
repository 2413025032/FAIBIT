import '../models/models.dart';

const materials = [
  LearningMaterial(
    'Desimal',
    'Pengenalan sistem bilangan desimal',
    '125₁₀ = 1×10² + 2×10¹ + 5×10⁰',
  ),
  LearningMaterial(
    'Biner',
    'Pengenalan sistem bilangan biner',
    '1011₂ = 8 + 0 + 2 + 1 = 11₁₀',
  ),
  LearningMaterial(
    'Oktal',
    'Pengenalan sistem bilangan oktal',
    '17₈ = 1×8 + 7 = 15₁₀',
  ),
  LearningMaterial(
    'Heksadesimal',
    'Pengenalan sistem bilangan heksadesimal',
    '1A₁₆ = 1×16 + 10 = 26₁₀',
  ),
  LearningMaterial(
    'Konversi',
    'Konversi antar sistem bilangan',
    '10₁₀ = 1010₂',
  ),
];

const questions = [
  Question(
    'Bilangan biner menggunakan basis ...',
    ['2', '8', '10', '16'],
    0,
    'Sistem bilangan biner menggunakan basis 2.',
  ),

  Question(
    'Simbol yang digunakan dalam bilangan biner adalah ...',
    ['1 dan 2', '0 dan 1', '0 dan 2', '1 dan 10'],
    1,
    'Bilangan biner hanya menggunakan dua simbol, yaitu 0 dan 1.',
  ),

  Question(
    '(1011)₂ = ...₁₀',
    ['9', '10', '11', '12'],
    2,
    '1011₂ = 1×8 + 0×4 + 1×2 + 1×1 = 11₁₀.',
  ),

  Question(
    '(11010)₂ = ...₁₀',
    ['24', '25', '26', '27'],
    2,
    '11010₂ = 16 + 8 + 0 + 2 + 0 = 26₁₀.',
  ),

  Question(
    '(100001)₂ = ...₁₀',
    ['31', '32', '33', '34'],
    2,
    '100001₂ = 32 + 1 = 33₁₀.',
  ),

  Question(
    '(11111)₂ = ...₁₀',
    ['29', '30', '31', '32'],
    2,
    '11111₂ = 16 + 8 + 4 + 2 + 1 = 31₁₀.',
  ),

  Question(
    'Bilangan 1010 terdiri dari ... bit.',
    ['2', '3', '4', '8'],
    2,
    'Bilangan 1010 memiliki empat digit biner, sehingga terdiri dari 4 bit.',
  ),

  Question(
    'Bilangan 11001100 terdiri dari ... bit.',
    ['4', '6', '8', '10'],
    2,
    'Bilangan 11001100 memiliki delapan digit biner, sehingga terdiri dari 8 bit.',
  ),

  Question(
    'Delapan bit dikenal sebagai satu ...',
    ['word', 'byte', 'nibble', 'digit'],
    1,
    'Dalam materi FAIBIT, delapan bit dikenal sebagai satu byte.',
  ),

  Question(
    'Bilangan yang muncul setelah 111₂ dalam urutan biner adalah ...',
    ['1111₂', '1000₂', '1010₂', '1100₂'],
    1,
    'Setelah 111₂, semua posisi bernilai 1 sehingga penambahan satu membentuk posisi baru di sebelah kiri: 1000₂.',
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
