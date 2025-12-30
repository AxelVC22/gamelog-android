import 'package:flutter/material.dart' hide Notification;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/notifications/retrieve_notifications_response.dart';
import 'package:gamelog/features/notifications/controllers/retrieve_notifications_controller.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import '../../../core/domain/entities/notification.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/presentation/failure_handler.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_notification_card.dart';
import '../../../widgets/app_skeleton_loader.dart';

final retrieveResultsProvider = StateProvider.autoDispose<List<Notification>>(
      (ref) => [],
);

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {

  bool isLoading = false;
  bool notFoundResults = false;
  late final ProviderSubscription _retrieveNotificationsSub;


  @override
  void initState() {
    super.initState();

    _retrieveNotificationsSub = ref
        .listenManual<AsyncValue<RetrieveNotificationsResponse?>>(
      retrieveNotificationsControllerProvider,
      _onRetrieveNotificationsChanged,
    );
    Future.microtask(() => _retrieveNotifications());

  }

  Future<void> _retrieveNotifications() async {
    if (!mounted) return;

    setState(() => isLoading = true);
    setState(() => notFoundResults = false);

    ref.read(retrieveResultsProvider.notifier).state = [];

    int idPlayer = ref.read(currentUserProvider.notifier).state!.idPlayer;

    await ref
        .read(retrieveNotificationsControllerProvider.notifier)
        .retrieveNotifications(idPlayer);
  }

  void _onRetrieveNotificationsChanged(
      AsyncValue<RetrieveNotificationsResponse?>? previous,
      AsyncValue<RetrieveNotificationsResponse?> next,
      ) {
    if (!mounted) return;
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) {
          if (response == null) return;

          if (response.notifications.isEmpty) {
            setState(() => notFoundResults = true);
          }

          ref.read(retrieveResultsProvider.notifier).state = response.notifications;
        },
        error: (error, __) {
          if (!mounted) return;
          setState(() => notFoundResults = true);
          handleFailure(context: context, error: error);
        },
      );
    }
  }


  @override
  void dispose() {
    _retrieveNotificationsSub.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final results = ref.watch(retrieveResultsProvider);


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
              const SizedBox(height: 12),

              if (notFoundResults)
                Text('Sin resultados')
              else if (results.isEmpty)
                const AppSkeletonLoader.listTile()

              else
                Expanded(

                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      return AppNotificationCard(
                        date: DateTime.now(),
                        onDelete: () {},
                        onTap: () {

                        }, message: results[i].message
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
