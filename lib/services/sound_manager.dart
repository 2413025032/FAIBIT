import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class SoundManager {
  SoundManager._();

  static final SoundManager instance = SoundManager._();

  final AudioPlayer _buttonPlayer = AudioPlayer();
  final AudioPlayer _correctPlayer = AudioPlayer();
  final AudioPlayer _wrongPlayer = AudioPlayer();
  final AudioPlayer _completePlayer = AudioPlayer();
  final AudioPlayer _faiPlayer = AudioPlayer();
  final AudioPlayer _pagePlayer = AudioPlayer();

  static const List<String> _assetPaths = [
    'audio/buttons/button_click.mp3',
    'audio/quiz/correct_answer.mp3',
    'audio/quiz/wrong_answer.mp3',
    'audio/quiz/quiz_complete.mp3',
    'audio/fai/fai_celebration.mp3',
    'audio/fai/fai_encouragement.mp3',
  ];

  static final AudioContext _audioContext = AudioContext(
    android: AudioContextAndroid(
      usageType: AndroidUsageType.game,
      contentType: AndroidContentType.sonification,
      audioFocus: AndroidAudioFocus.gain,
    ),
  );

  double _volume = 0.8;
  bool _isMuted = false;
  bool _initialized = false;
  Future<void>? _initializing;

  Future<void> initialize() async {
    if (_initialized) return;
    final pending = _initializing;
    if (pending != null) {
      await pending;
      return;
    }

    final initialization = _initializePlayers();
    _initializing = initialization;
    try {
      await initialization;
      _initialized = true;
    } finally {
      if (identical(_initializing, initialization)) {
        _initializing = null;
      }
    }
  }

  Future<void> _initializePlayers() async {
    // Make the expected Flutter asset root explicit, rather than relying on
    // another plugin or player to have changed the shared AudioCache prefix.
    AudioCache.instance = AudioCache(prefix: 'assets/');

    final players = [
      _buttonPlayer,
      _correctPlayer,
      _wrongPlayer,
      _completePlayer,
      _faiPlayer,
      _pagePlayer,
    ];

    for (final player in players) {
      try {
        await player.setAudioContext(_audioContext);
        await player.setReleaseMode(ReleaseMode.stop);
        await player.setVolume(_volume);
      } catch (error, stackTrace) {
        // Keep default native audio settings if a device rejects the context.
        debugPrint('FAIBIT gagal mengatur audio player: $error');
        debugPrintStack(stackTrace: stackTrace);
      }
    }

    // Preload SFX to surface missing asset paths before a quiz is started.
    try {
      await AudioCache.instance.loadAll(_assetPaths);
      debugPrint('FAIBIT SFX siap: ${_assetPaths.length} aset audio dimuat.');
    } catch (error, stackTrace) {
      debugPrint('FAIBIT gagal memuat aset SFX: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _play(AudioPlayer player, String path) async {
    if (_isMuted) return;

    try {
      if (!_initialized) await initialize();
      if (_isMuted) return;
      await player.stop();
      await player.setVolume(_volume);
      await player.play(AssetSource(path, mimeType: 'audio/mpeg'));
      debugPrint('FAIBIT SFX diputar: $path');
    } catch (error, stackTrace) {
      debugPrint('FAIBIT gagal memutar audio "$path": $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> playButtonClick() =>
      _play(_buttonPlayer, 'audio/buttons/button_click.mp3');

  Future<void> playCountdownTick() => playButtonClick();

  Future<void> playPageTurn() =>
      _play(_pagePlayer, 'audio/buttons/page_turn.mp3');

  Future<void> playCorrectAnswer() =>
      _play(_correctPlayer, 'audio/quiz/correct_answer.mp3');

  Future<void> playWrongAnswer() =>
      _play(_wrongPlayer, 'audio/quiz/wrong_answer.mp3');

  Future<void> playQuizComplete() =>
      _play(_completePlayer, 'audio/quiz/quiz_complete.mp3');

  Future<void> playFaiCelebration() =>
      _play(_faiPlayer, 'audio/fai/fai_celebration.mp3');

  Future<void> playFaiEncouragement() =>
      _play(_faiPlayer, 'audio/fai/fai_encouragement.mp3');

  Future<void> stopFai() => _faiPlayer.stop();

  Future<void> stop() async {
    await Future.wait([
      _buttonPlayer.stop(),
      _correctPlayer.stop(),
      _wrongPlayer.stop(),
      _completePlayer.stop(),
      _faiPlayer.stop(),
      _pagePlayer.stop(),
    ]);
  }

  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0).toDouble();
    if (_isMuted) return;

    await Future.wait([
      _buttonPlayer.setVolume(_volume),
      _correctPlayer.setVolume(_volume),
      _wrongPlayer.setVolume(_volume),
      _completePlayer.setVolume(_volume),
      _faiPlayer.setVolume(_volume),
      _pagePlayer.setVolume((_volume * 0.45).clamp(0.0, 1.0)),
    ]);
  }

  Future<void> setMuted(bool muted) async {
    _isMuted = muted;
    if (_isMuted) {
      await stop();
      return;
    }

    await setVolume(_volume);
  }

  bool get isMuted => _isMuted;
  double get volume => _volume;

  Future<void> dispose() async {
    await Future.wait([
      _buttonPlayer.dispose(),
      _correctPlayer.dispose(),
      _wrongPlayer.dispose(),
      _completePlayer.dispose(),
      _faiPlayer.dispose(),
      _pagePlayer.dispose(),
    ]);
  }
}
