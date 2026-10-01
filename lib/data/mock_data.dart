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
    '(1011)₂ = …₁₀',
    ['9', '10', '11', '12'],
    2,
    'Nilai biner 1011 adalah 8 + 0 + 2 + 1, sehingga hasilnya 11.',
  ),
  Question(
    '(17)₈ = …₁₀',
    ['13', '14', '15', '16'],
    2,
    'Nilai oktal 17 adalah 1×8 + 7, sehingga hasilnya 15.',
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
