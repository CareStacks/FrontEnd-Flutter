import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class CaregiverHomePage extends StatelessWidget {
  const CaregiverHomePage({super.key});

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
        const Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              24,
              AppSpacing.screenPadding,
              28,
            ),
            child: _HomeContent(),
          ),
        ),
      ],
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buenos dias,',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text('Hola, Patricia', style: AppTextStyles.headlineLarge),
        const SizedBox(height: 28),
        const CareSectionTitle('PACIENTES ASIGNADOS'),
        const SizedBox(height: 16),
        const _AssignedPatientCard(),
        const SizedBox(height: 24),
        CareEventCard(
          icon: Icons.medical_services_outlined,
          title: 'Elena - 8:00\na. m.',
          description: 'Losartan 50mg - 1\ncomprimido',
          badge: const CareBadge(
            label: 'PENDIENTE',
            backgroundColor: AppColors.orangeLight,
            foregroundColor: AppColors.neutral,
          ),
          actionLabel: 'Confirmar toma',
          onActionPressed: () {},
        ),
        const SizedBox(height: 24),
        CareMetricSummaryCard(
          title: 'RESUMEN TAREAS DE ELENA',
          metrics: const [
            CareMetric(
              value: '0',
              label: 'ALERTAS',
              color: AppColors.redDark,
              icon: Icons.block,
            ),
            CareMetric(
              value: '8',
              label: 'COMPLETADO',
              color: AppColors.greenDark,
            ),
            CareMetric(
              value: '2',
              label: 'OMITIDO',
              color: AppColors.textMuted,
            ),
          ],
        ),
        const SizedBox(height: 26),
        const CareSectionTitle('ACCIONES RAPIDAS'),
        const SizedBox(height: 16),
        CareActionTile(
          icon: Icons.account_circle_outlined,
          label: 'Ver perfil compartido',
          onTap: () {},
        ),
        const SizedBox(height: 14),
        CareActionTile(
          icon: Icons.folder_copy_outlined,
          label: 'Ver documentos',
          onTap: () {},
        ),
        const SizedBox(height: 14),
        CareActionTile(
          icon: Icons.menu_book_outlined,
          label: 'Ver diario',
          onTap: () {},
        ),
      ],
    );
  }
}

class _AssignedPatientCard extends StatelessWidget {
  const _AssignedPatientCard();

  @override
  Widget build(BuildContext context) {
    return CareInfoTile(
      icon: Icons.person_outline,
      title: 'Elena Garcia',
      subtitle: 'Estable',
      onTap: () {},
      iconBackgroundColor: AppColors.greenLight,
      iconColor: AppColors.greenDark,
    );
  }
}
