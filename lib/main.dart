import 'package:flutter/material.dart';

import 'screens/identity_splash.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FaibitApp());
}

class FaibitApp extends StatelessWidget {
  const FaibitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAIBIT',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
