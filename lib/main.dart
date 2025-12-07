import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NandixApp());
}

class NandixApp extends StatelessWidget {
  const NandixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NANDIX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF102E4A),
        scaffoldBackgroundColor: const Color(0xFFF5F0E8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF102E4A),
          primary: const Color(0xFF102E4A),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
