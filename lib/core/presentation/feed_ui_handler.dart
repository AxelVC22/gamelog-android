import 'package:flutter/material.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';
import '../../l10n/app_localizations.dart';

void handleSnackBarMessage({
  required BuildContext context,
  required String code,
}) {
  final l10n = AppLocalizations.of(context);
  if (l10n == null) return;

  String text = l10n.byKey(code);

  if (text == code || text.isEmpty) {
    text =  code;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  });
}
