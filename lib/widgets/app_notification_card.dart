import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppNotificationCard extends StatelessWidget {
  final VoidCallback? onTap;
  final DateTime date;
  final String message;
  final VoidCallback? onDelete;

  const AppNotificationCard({
    super.key,
    this.onTap,
    required this.date,
    required this.message,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      DateFormat('EEE, M/d/y').format(date),
                      style: const TextStyle(fontSize: 11),
                    ),
                    Text(
                      message,
                      softWrap: true,
                      style: const TextStyle(fontSize: 16),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
