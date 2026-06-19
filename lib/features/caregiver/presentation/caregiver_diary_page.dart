import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/date_formatters.dart';
import '../../../core/widgets/widgets.dart';
import '../data/caregiver_models.dart';

class CaregiverDiaryPage extends StatelessWidget {
  const CaregiverDiaryPage({
    super.key,
    required this.dashboard,
    required this.onNotificationsPressed,
  });

  final CaregiverDashboardData dashboard;
  final VoidCallback onNotificationsPressed;

  @override
  Widget build(BuildContext context) {
    final patient = dashboard.activePatient;
    final entries = dashboard.diaryEntries;

    return Column(
      children: [
        Container(
          color: AppColors.backgroundSoft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CareTopBar(
            title: 'Diario',
            onNotificationsPressed: onNotificationsPressed,
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              24,
              AppSpacing.screenPadding,
              28,
            ),
            children: [
              Text(
                'Registro del bienestar diario',
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: 6),
              Text(
                patient?.patientFullName ?? 'Sin paciente activo',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              if (patient == null)
                const _DiaryEmptyState(
                  message: 'Acepta una invitación para revisar el diario.',
                )
              else if (!patient.allows('DIARY'))
                const _DiaryEmptyState(
                  message: 'Este paciente no compartió permisos de diario.',
                )
              else if (entries.isEmpty)
                const _DiaryEmptyState(
                  message: 'Todavía no hay notas en el diario compartido.',
                )
              else
                for (final entry in entries) ...[
                  CareNoteCard(
                    author: patient.patientFullName,
                    timestamp: CareDateFormatters.dateTime(entry.entryDate),
                    body: entry.content,
                    badges: const [
                      CareBadge(
                        label: 'Nota diaria',
                        backgroundColor: AppColors.primaryLight,
                        foregroundColor: AppColors.primaryDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                ],
            ],
          ),
        ),
      ],
    );
  }
}

class _DiaryEmptyState extends StatelessWidget {
  const _DiaryEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return CareCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const CareIconBubble(
            icon: Icons.edit_note_outlined,
            size: 58,
            iconSize: 28,
          ),
          const SizedBox(height: 14),
          Text(
            message,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
