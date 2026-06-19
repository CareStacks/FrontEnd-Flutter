import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/date_formatters.dart';
import '../../../core/widgets/widgets.dart';
import '../data/caregiver_models.dart';
import 'caregiver_ui_helpers.dart';

class CaregiverAgendaPage extends StatelessWidget {
  const CaregiverAgendaPage({
    super.key,
    required this.dashboard,
    required this.onConfirmEvent,
    required this.onNotificationsPressed,
    required this.onRefresh,
  });

  final CaregiverDashboardData dashboard;
  final Future<void> Function(String eventId) onConfirmEvent;
  final VoidCallback onNotificationsPressed;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final patient = dashboard.activePatient;
    final events = [...dashboard.events]
      ..sort((a, b) => (a.startAt ?? '').compareTo(b.startAt ?? ''));

    return Column(
      children: [
        Container(
          color: AppColors.backgroundSoft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CareTopBar(
            title: 'Agenda',
            onNotificationsPressed: onNotificationsPressed,
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                24,
                AppSpacing.screenPadding,
                28,
              ),
              children: [
                Text('Eventos de hoy', style: AppTextStyles.headlineMedium),
                const SizedBox(height: 6),
                Text(
                  patient == null
                      ? 'Acepta una invitación para revisar la agenda.'
                      : patient.patientFullName,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                if (patient == null)
                  const _EmptyAgenda(message: 'No hay paciente activo.')
                else if (!patient.allows('AGENDA'))
                  const _EmptyAgenda(
                    message: 'Este paciente no compartió permisos de agenda.',
                  )
                else if (events.isEmpty)
                  const _EmptyAgenda(
                    message:
                        'Aún no hay eventos sincronizados para este paciente.',
                  )
                else
                  for (final event in events) ...[
                    _AgendaEventCard(
                      event: event,
                      onConfirm: event.status == 'PENDING'
                          ? () => onConfirmEvent(event.id)
                          : null,
                    ),
                    const SizedBox(height: 14),
                  ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AgendaEventCard extends StatelessWidget {
  const _AgendaEventCard({required this.event, required this.onConfirm});

  final HealthEvent event;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return CareCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CareIconBubble(
                icon: eventIcon(event.type),
                backgroundColor: AppColors.primaryLight,
                iconColor: AppColors.primaryDark,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      eventTypeLabel(event.type),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              CareBadge(
                label: eventStatusLabel(event.status),
                backgroundColor: eventStatusBackground(event.status),
                foregroundColor: eventStatusForeground(event.status),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            text: CareDateFormatters.date(event.startAt),
          ),
          const SizedBox(height: 8),
          _InfoRow(
            icon: Icons.schedule,
            text: CareDateFormatters.timeRange(event.startAt, event.endAt),
          ),
          if (event.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              event.description,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          if (onConfirm != null) ...[
            const SizedBox(height: 16),
            CarePrimaryButton(
              label: 'Confirmar evento',
              icon: Icons.check_circle_outline,
              onPressed: onConfirm,
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.iconMuted),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyAgenda extends StatelessWidget {
  const _EmptyAgenda({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return CareCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const CareIconBubble(
            icon: Icons.event_busy_outlined,
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
