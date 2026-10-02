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

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
      child: Text(
        'FAIBIT',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w800,
          letterSpacing: 4,
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
