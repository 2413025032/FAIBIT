import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../models/models.dart';
import 'home_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _fade = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _scale = Tween<double>(begin: 0.92, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const IdentityPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    body: FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/branding/logo_faibit.png',
                  width: 148,
                  height: 148,
                  fit: BoxFit.contain,
                  semanticLabel: 'Logo FAIBIT',
                ),
                const SizedBox(height: 14),
                Text(
                  'FAIBIT',
                  style: Theme.of(context).textTheme.displaySmall
                      ?.copyWith(letterSpacing: 3, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  'Belajar Sistem Bilangan Jadi Lebih Seru!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class IdentityPage extends StatefulWidget {
  const IdentityPage({super.key});
  @override
  State<IdentityPage> createState() => _IdentityPageState();
}

class _IdentityPageState extends State<IdentityPage> {
  final key = GlobalKey<FormState>();
  final name = TextEditingController();
  final schoolClass = TextEditingController();
  final school = TextEditingController();
  @override
  void dispose() {
    name.dispose();
    schoolClass.dispose();
    school.dispose();
    super.dispose();
  }

  void submit() {
    if (key.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeShell(
            profile: UserProfile(
              name: name.text.trim(),
              schoolClass: schoolClass.text.trim(),
              school: school.text.trim(),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: SizedBox(
                        width: 78,
                        child: LinearProgressIndicator(
                          value: .35,
                          color: AppTheme.ink,
                          backgroundColor: Color(0xFFD8D8D8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 34),
                    const Text(
                      'Halo!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Sebelum mulai, yuk isi identitasmu dulu.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 22),
                    const Center(
                      child: CircleAvatar(
                        radius: 34,
                        backgroundColor: Color(0xFFF3F3F3),
                        child: Icon(
                          Icons.person_outline,
                          size: 38,
                          color: AppTheme.ink,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      controller: name,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        hintText: 'Nama',
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Nama wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: schoolClass,
                      onFieldSubmitted: (_) => submit(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.school_outlined),
                        hintText: 'Kelas',
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Kelas wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: school,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => submit(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.business_outlined),
                        hintText: 'Sekolah',
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Sekolah wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 28),
                    FilledButton(
                      onPressed: submit,
                      child: const Text('Mulai Belajar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
