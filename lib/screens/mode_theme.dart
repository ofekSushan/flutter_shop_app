import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:provider/provider.dart';
import '../providers/theme.dart';

class ModeScreen extends StatelessWidget {
  static const routeName = '/ModeScreen';

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    bool isLightmod = themeChanger.isLightmod(themeChanger.themeMode);
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
          ),
          RadioListTile<ThemeMode>(
            title: Text(
              'Light Mode',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            groupValue: themeChanger.themeMode,
            value: ThemeMode.light,
            onChanged: themeChanger.setTheme,
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark Mode'),
            groupValue: themeChanger.themeMode,
            value: ThemeMode.dark,
            onChanged: themeChanger.setTheme,
          ),
          FloatingActionButton(
            onPressed: () {
              isLightmod
                  ? themeChanger.setTheme(ThemeMode.dark)
                  : themeChanger.setTheme(ThemeMode.light);
            },
            child: Icon(
              isLightmod ? Icons.dark_mode : Icons.light_mode,
            ),
          )
        ],
      ),
    );
  }
}
