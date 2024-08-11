import 'package:flutter/material.dart';
import 'package:prodigy_ad_05/util/settings/settings_model.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, SettingsModel settingsNotifier, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    title: Text('Dark mode'),
                    subtitle: Text('Switch between light and dark mode'),
                  ),
                ),
                Switch(
                  value: settingsNotifier.isDark,
                  onChanged: (_) {
                    settingsNotifier.isDark
                        ? settingsNotifier.isDark = false
                        : settingsNotifier.isDark = true;
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    title: Text('Keep Scan History'),
                    subtitle: Text('Turn of to disable history'),
                  ),
                ),
                Switch(
                  value: settingsNotifier.keepHistory,
                  onChanged: (_) {
                    settingsNotifier.keepHistory
                        ? settingsNotifier.keepHistory = false
                        : settingsNotifier.keepHistory = true;
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
