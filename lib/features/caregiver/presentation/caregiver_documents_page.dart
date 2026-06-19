import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/date_formatters.dart';
import '../../../core/widgets/widgets.dart';
import '../data/caregiver_models.dart';
import 'caregiver_ui_helpers.dart';

class CaregiverDocumentsPage extends StatefulWidget {
  const CaregiverDocumentsPage({
    super.key,
    required this.dashboard,
    required this.onNotificationsPressed,
  });

  final CaregiverDashboardData dashboard;
  final VoidCallback onNotificationsPressed;

  @override
  State<CaregiverDocumentsPage> createState() => _CaregiverDocumentsPageState();
}

class _CaregiverDocumentsPageState extends State<CaregiverDocumentsPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final patient = widget.dashboard.activePatient;
    final documents = widget.dashboard.documentItems.where((item) {
      final query = _query.toLowerCase();
      return item.title.toLowerCase().contains(query) ||
          item.documentType.toLowerCase().contains(query);
    }).toList();

    return Column(
      children: [
        Container(
          color: AppColors.backgroundSoft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CareTopBar(
            title: 'Documentos',
            onNotificationsPressed: widget.onNotificationsPressed,
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
                'Gestiona y revisa el historial médico de forma segura.',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 18),
              CareSearchField(
                hintText: 'Buscar documentos...',
                onChanged: (value) => setState(() => _query = value),
              ),
              const SizedBox(height: 24),
              if (patient == null)
                const _DocumentEmptyState(
                  message:
                      'Acepta una invitación para ver documentos compartidos.',
                )
              else if (!patient.allows('DOCUMENTS'))
                const _DocumentEmptyState(
                  message: 'Este paciente no compartió permisos de documentos.',
                )
              else if (documents.isEmpty)
                const _DocumentEmptyState(
                  message: 'No hay documentos sincronizados.',
                )
              else ...[
                const CareSectionTitle('RECIENTES'),
                const SizedBox(height: 14),
                for (final item in documents) ...[
                  CareDocumentTile(
                    icon: documentIcon(item.documentType),
                    title: item.title,
                    typeLabel: documentTypeLabel(item.documentType),
                    dateLabel: CareDateFormatters.date(item.uploadedAt),
                    badgeBackgroundColor: toneBackground(
                      item.documentType == 'IMAGING' ? 'orange' : 'purple',
                    ),
                    badgeTextColor: toneForeground(
                      item.documentType == 'IMAGING' ? 'orange' : 'purple',
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _DocumentEmptyState extends StatelessWidget {
  const _DocumentEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return CareCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const CareIconBubble(
            icon: Icons.folder_off_outlined,
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
