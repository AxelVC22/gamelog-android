import 'package:flutter/material.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';
import '../../l10n/app_localizations.dart';
import '../domain/failures/failure.dart';

void handleFailure({required BuildContext context, required Object error}) {
  final l10n = AppLocalizations.of(context);
  if (l10n != null) {
    final message = error is Failure
        ? (error.serverMessage ?? l10n.byKey(error.code))
        : error.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Información'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}
