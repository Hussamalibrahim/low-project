import 'package:flutter/material.dart';

class AppStatusBadge extends StatelessWidget {
  final String label;
  final Color? color;
  final IconData? icon;

  const AppStatusBadge({
    super.key,
    required this.label,
    this.color,
    this.icon,
  });

  static String localizeStatus(String status) {
    switch (status.trim().toUpperCase()) {
      case 'OPEN':
        return 'قيد النظر';
      case 'SCHEDULED':
        return 'مجدولة';
      case 'POSTPONED':
        return 'مؤجلة';
      case 'PENDING':
      case 'ON_HOLD':
      case 'HELD':
        return 'معلقة';
      case 'APPEALED':
        return 'طعن';
      case 'EXECUTION':
        return 'قيد التنفيذ';
      case 'CLOSED':
      case 'RESOLVED':
        return 'مفصولة';
      case 'COMPLETED':
      case 'DONE':
        return 'منجز';
      case 'CANCELLED':
        return 'ملغى';
      default:
        return status;
    }
  }

  static Color defaultColorForStatus(String arabicStatus, BuildContext context) {
    switch (arabicStatus) {
      case 'قيد النظر':
      case 'مجدولة':
        return Colors.blue;
      case 'مؤجلة':
        return Colors.orange.shade800;
      case 'معلقة':
        return Colors.amber.shade800;
      case 'طعن':
        return Colors.purple;
      case 'قيد التنفيذ':
        return Colors.teal;
      case 'مفصولة':
      case 'مفصولة / محسومة':
        return Colors.blueGrey;
      case 'منجز':
        return Colors.green;
      case 'ملغى':
        return Colors.red;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayLabel = localizeStatus(label);
    final badgeColor = color ?? defaultColorForStatus(displayLabel, context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: badgeColor.withAlpha(70),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: badgeColor),
            const SizedBox(width: 4),
          ],
          Text(
            displayLabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
