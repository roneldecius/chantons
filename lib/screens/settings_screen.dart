import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../localization/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final loc = AppLocalizations(settings.languageCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.get('settings')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text(loc.get('high_contrast'), style: const TextStyle(fontWeight: FontWeight.bold)),
            value: settings.isHighContrast,
            onChanged: (val) => settings.setHighContrast(val),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(loc.get('text_size'), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Slider(
            value: settings.textSizeMultiplier,
            min: 0.8,
            max: 2.5,
            divisions: 17,
            label: '${settings.textSizeMultiplier.toStringAsFixed(1)}x',
            onChanged: (val) => settings.setTextSizeMultiplier(val),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(loc.get('language'), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          RadioListTile<String>(
            title: Text(loc.get('french')),
            value: 'fr',
            groupValue: settings.languageCode,
            onChanged: (val) {
              if (val != null) settings.setLanguageCode(val);
            },
          ),
          RadioListTile<String>(
            title: Text(loc.get('creole')),
            value: 'ht',
            groupValue: settings.languageCode,
            onChanged: (val) {
              if (val != null) settings.setLanguageCode(val);
            },
          ),
        ],
      ),
    );
  }
}
