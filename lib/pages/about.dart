import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ListTile(
          leading: Icon(Icons.person_rounded),
          title: Text('ashenafiDL'),
          subtitle: Text('Author'),
        ),
        ListTile(
          leading: Icon(Icons.change_circle_rounded),
          title: Text('1.0.0'),
          subtitle: Text("Version"),
        ),
        ListTile(
          leading: Icon(Icons.code_rounded),
          title: Text('https://github.com/ashenafiDL/PRODIGY_AD-05'),
          subtitle: Text('Source Code'),
        ),
      ],
    );
  }
}
