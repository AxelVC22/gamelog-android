import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gamelog/widgets/app_global_loader.dart';
import 'package:gamelog/core/theme/dark_theme.dart';

import 'core/services/notification_service.dart';
import 'features/auth/views/login_screen.dart';
import 'core/presentation/main_layout.dart';
import 'features/auth/state/auth_state.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(authBootstrapProvider);
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      key: ValueKey(authState.status),

      title: 'GameLog',
      theme: darkTheme,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es')],

      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            const GlobalLoader(),
          ],
        );
      },

      home: bootstrap.when(
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (_, __) => const LoginScreen(),
        data: (_) => authState.status == AuthStatus.authenticated
            ? const MainLayout()
            : const LoginScreen(),
      ),
    );
  }
}