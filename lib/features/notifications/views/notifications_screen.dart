import 'package:flutter/material.dart' hide Notification;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import '../../../core/domain/entities/notification.dart';

import '../../../core/domain/entities/player.dart';

import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_notification_card.dart';


class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  List<Notification> allNotifications = [
    Notification(
      id: 0,
      message: "follow",
      notified: Player(username: 'Tu'),
      notifier: Player(username: 'Papoi'),
      date: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _search('p');
  }

  List<Notification> results = [];
  bool isLoading = false;

  Future<void> _search(String query) async {
    setState(() => isLoading = true);

    // Simula un delay de API
    await Future.delayed(const Duration(milliseconds: 600));

    setState(() {
      results = allNotifications
          .where(
            (notification) =>
                notification.notifier.username.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();

      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.notificationsTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              if (isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      return AppNotificationCard(
                        date: DateTime.now(),
                        onDelete: () {},
                        onTap: () {

                        }, message: l10n.newFollowerNotification(
                        results[i].notifier.username
                      ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
