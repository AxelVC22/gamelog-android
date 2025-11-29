import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/widgets/app_global_loader.dart';
import 'features/auth/views/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gamelog/l10n/app_localizations.dart';

Future<void> main() async{
  await dotenv.load(fileName: '.env');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [ Locale('es', ''), ],
      locale: const Locale('es'),

      title: 'GameLog',

      theme: ThemeData(primarySwatch: Colors.red),

      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            const GlobalLoader(),
          ],
        );
      },

      home: const LoginScreen(),
    );
  }
}