import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import 'caregiver_home_page.dart';

class CaregiverMainPage extends StatefulWidget {
  const CaregiverMainPage({super.key});

  @override
  State<CaregiverMainPage> createState() => _CaregiverMainPageState();
}

class _CaregiverMainPageState extends State<CaregiverMainPage> {
  CareNavDestination _currentDestination = CareNavDestination.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentDestination.index,
        children: const [
          CaregiverHomePage(),
          _CaregiverPlaceholderPage(title: 'Agenda'),
          _CaregiverPlaceholderPage(title: 'Documentos'),
          _CaregiverPlaceholderPage(title: 'Diario'),
          _CaregiverPlaceholderPage(title: 'Perfil'),
        ],
      ),
      bottomNavigationBar: CareBottomNavBar(
        currentDestination: _currentDestination,
        onDestinationSelected: (destination) {
          setState(() {
            _currentDestination = destination;
          });
        },
      ),
    );
  }
}

class _CaregiverPlaceholderPage extends StatelessWidget {
  const _CaregiverPlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.backgroundSoft,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: const CareTopBar(),
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
