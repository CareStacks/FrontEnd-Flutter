import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum CareNavDestination {
  home(
    label: 'Inicio',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
  ),
  agenda(
    label: 'Agenda',
    icon: Icons.calendar_month_outlined,
    selectedIcon: Icons.calendar_month,
  ),
  documents(
    label: 'Documentos',
    icon: Icons.description_outlined,
    selectedIcon: Icons.description,
  ),
  diary(
    label: 'Diario',
    icon: Icons.edit_note,
    selectedIcon: Icons.edit_note,
  ),
  profile(
    label: 'Perfil',
    icon: Icons.person_outline,
    selectedIcon: Icons.person,
  );

  const CareNavDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

class CareBottomNavBar extends StatelessWidget {
  const CareBottomNavBar({
    super.key,
    required this.currentDestination,
    required this.onDestinationSelected,
  });

  final CareNavDestination currentDestination;
  final ValueChanged<CareNavDestination> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 78,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(color: AppColors.border),
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Row(
          children: CareNavDestination.values.map((destination) {
            final bool selected = currentDestination == destination;
            return Expanded(
              child: _CareBottomNavItem(
                destination: destination,
                selected: selected,
                onTap: () => onDestinationSelected(destination),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _CareBottomNavItem extends StatelessWidget {
  const _CareBottomNavItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final CareNavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = selected ? AppColors.surface : AppColors.neutral;

    return Semantics(
      selected: selected,
      button: true,
      label: destination.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? destination.selectedIcon : destination.icon,
                color: color,
                size: 22,
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  destination.label,
                  maxLines: 1,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
