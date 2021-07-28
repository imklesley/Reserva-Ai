import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '/controllers/stores/app_config_store.dart';
import '/controllers/stores/auth_store.dart';
import '/controllers/stores/theme_store.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppConfigStore>(context).themeStore;
    final auth = Provider.of<AuthStore>(context);

    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lalalala'),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Observer(
            builder: (BuildContext context) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Text('Change your app theme:'),
                      ListTile(
                        title: const Text('System'),
                        leading: Radio<Mode>(
                          value: Mode.system,
                          groupValue: theme.currentThemeRadio,
                          onChanged: (Mode? mode) {
                            theme.setThemeMode(ThemeMode.system);
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Light'),
                        leading: Radio<Mode>(
                          value: Mode.light,
                          groupValue: theme.currentThemeRadio,
                          onChanged: (Mode? mode) {
                            theme.setThemeMode(ThemeMode.light);
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Dark'),
                        leading: Radio<Mode>(
                          value: Mode.dark,
                          groupValue: theme.currentThemeRadio,
                          onChanged: (Mode? mode) {
                            theme.setThemeMode(ThemeMode.dark);
                          },
                        ),
                      ),
                      const Spacer(),
                      TextButton(onPressed: (){
                        Provider.of<AuthStore>(context).signOut();
                      }, child: Text('Sair'))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/welcome');
            },
            child: const Text('Welcome View'),
          ),
        ));
  }
}
