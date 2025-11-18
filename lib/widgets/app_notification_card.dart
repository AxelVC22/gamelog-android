import 'package:flutter/material.dart';
import 'package:gamelog/widgets/app_icon_button.dart';
import 'package:intl/intl.dart';

import 'app_like_button.dart';

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
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [


              Column(
                children: [

                  Text(
                    DateFormat('dd/MM/yyyy').format(date),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),

              AppIconButton(
                icon: Icons.delete,
                onPressed: onDelete,
              )
            ],
          ),


        ),
      ),
    );
  }
}
