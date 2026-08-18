import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: const ChantonsApp(),
    ),
  );
}

class ChantonsApp extends StatelessWidget {
  const ChantonsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        final isHighContrast = settings.isHighContrast;
        final theme = ThemeData(
          useMaterial3: true,
          colorScheme: isHighContrast
              ? const ColorScheme.highContrastLight()
              : ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: isHighContrast
              ? const AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black)
              : null,
        );

        final darkTheme = ThemeData(
          useMaterial3: true,
          colorScheme: isHighContrast
              ? const ColorScheme.highContrastDark()
              : ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        );

        return MaterialApp(
          title: 'Chantons',
          theme: theme,
          darkTheme: darkTheme,
          themeMode: isHighContrast ? ThemeMode.dark : ThemeMode.system,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(
                textScaler: TextScaler.linear(settings.textSizeMultiplier),
              ),
              child: child!,
            );
          },
          home: const HomeScreen(),
        );
      },
    );
  }
}
