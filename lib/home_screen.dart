import 'package:flutter/material.dart';
import 'package:prodigy_ad_05/pages/about.dart';
import 'package:prodigy_ad_05/pages/generate.dart';
import 'package:prodigy_ad_05/pages/history.dart';
import 'package:prodigy_ad_05/pages/scan.dart';
import 'package:prodigy_ad_05/pages/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgets = <Widget>[
    Scan(),
    Generate(),
    History(),
    Settings(),
    About(),
  ];
  static const List<String> _appBarTitles = <String>[
    'Scan',
    'Generate',
    'History',
    'Settings',
    'About',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      drawer: Builder(builder: (context) {
        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'QR Code Scanner',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.qr_code_scanner_rounded),
                title: const Text('Scan'),
                onTap: () {
                  _onItemTapped(0);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.qr_code_rounded),
                title: const Text('Generate'),
                onTap: () {
                  _onItemTapped(1);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.history_rounded),
                title: const Text('History'),
                onTap: () {
                  _onItemTapped(2);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_rounded),
                title: const Text('Settings'),
                onTap: () {
                  _onItemTapped(3);
                  Navigator.of(context).pop();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_rounded),
                title: const Text('About'),
                onTap: () {
                  _onItemTapped(4);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }),
      body: Center(
        child: _widgets[_selectedIndex],
      ),
    );
  }
}
