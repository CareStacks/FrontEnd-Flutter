import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'features/caregiver/presentation/caregiver_main_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const CaregiverMainPage(),
    );
  }
}
