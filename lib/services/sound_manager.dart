import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class SoundManager {
  SoundManager._();

  static final SoundManager instance = SoundManager._();

  // Pemutar untuk klik dan efek suara singkat.
  final AudioPlayer _uiPlayer = AudioPlayer();

  // Pemutar khusus suara Fai agar tidak terpotong suara tombol.
  final AudioPlayer _faiPlayer = AudioPlayer();

  // Pemutar khusus efek membalik halaman materi.
  final AudioPlayer _pagePlayer = AudioPlayer();

  double _volume = 0.7;
  bool _isMuted = false;

  Future<void> _play(AudioPlayer player, String path) async {
    if (_isMuted) return;

    try {
      await player.stop();
      await player.setVolume(_volume);
      await player.play(AssetSource(path));
    } catch (e, stackTrace) {
      debugPrint('Gagal memutar audio "$path": $e');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  // SUARA TOMBOL
  Future<void> playButtonClick() {
    return _play(_uiPlayer, 'audio/buttons/button_click.mp3');
  }

  // SUARA HITUNG MUNDUR CHALLENGE
  Future<void> playCountdownTick() {
    return playButtonClick();
  }

  // SUARA SAAT HALAMAN MATERI BENAR-BENAR BERPINDAH
  Future<void> playPageTurn() async {
    if (_isMuted) return;

    try {
      await _pagePlayer.stop();
      await _pagePlayer.setVolume((_volume * 0.45).clamp(0.0, 1.0));
      await _pagePlayer.play(AssetSource('audio/buttons/page_turn.mp3'));
    } catch (e, stackTrace) {
      debugPrint('Gagal memutar audio page turn: $e');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  // SUARA JAWABAN LATIHAN SANTAI
  Future<void> playCorrectAnswer() {
    return _play(_uiPlayer, 'audio/quiz/correct_answer.mp3');
  }

  Future<void> playWrongAnswer() {
    return _play(_uiPlayer, 'audio/quiz/wrong_answer.mp3');
  }

  Future<void> playQuizComplete() {
    return _play(_uiPlayer, 'audio/quiz/quiz_complete.mp3');
  }

  // SUARA FAI SAAT ANIMASI HASIL CHALLENGE
  Future<void> playFaiCelebration() {
    return _play(_faiPlayer, 'audio/fai/fai_celebration.mp3');
  }

  Future<void> playFaiEncouragement() {
    return _play(_faiPlayer, 'audio/fai/fai_encouragement.mp3');
  }

  Future<void> stopFai() async {
    await _faiPlayer.stop();
  }

  Future<void> stop() async {
    await _uiPlayer.stop();
    await _faiPlayer.stop();
    await _pagePlayer.stop();
  }

  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0).toDouble();

    if (!_isMuted) {
      await _uiPlayer.setVolume(_volume);
      await _faiPlayer.setVolume(_volume);
      await _pagePlayer.setVolume((_volume * 0.45).clamp(0.0, 1.0));
    }
  }

  Future<void> setMuted(bool muted) async {
    _isMuted = muted;

    if (_isMuted) {
      await stop();
    } else {
      await _uiPlayer.setVolume(_volume);
      await _faiPlayer.setVolume(_volume);
      await _pagePlayer.setVolume((_volume * 0.45).clamp(0.0, 1.0));
    }
  }

  bool get isMuted => _isMuted;
  double get volume => _volume;
}