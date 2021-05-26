import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'config/router/routes.dart';
import 'config/themes/app_themes.dart';
import 'config/translations/l10n.dart';
import 'controllers/stores/app_config_store.dart';
import 'controllers/stores/auth_store.dart';

Future<void>  main() async {


  WidgetsFlutterBinding.ensureInitialized();

  //Inicializar a conexão com o firebase
  await Firebase.initializeApp();




  // Config Login Facebook
  if (kIsWeb) {
    FacebookAuth.i.webInitialize(
      appId: "1455007034849430",//Dados no facebook
      cookie: true,
      xfbml: true,
      version: "v9.0",
    );
  }




  //Inicializa o router
  Routes.setupRouter();

  //App
  runApp(ReservaAi());
}

class ReservaAi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Esconde status bar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    // TODO: fixar orientação em portrait

    return MultiProvider(
      providers: [
        Provider(create: (_) => AppConfigStore()),
        Provider(create: (_) => AuthStore())
      ],
      builder: (context, _) {
        final theme = Provider.of<AppConfigStore>(context).themeStore;
        return Observer(
          builder: (BuildContext context) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Reserva Ai!',
                themeMode: theme.themeMode,
                darkTheme: AppTheme.darkTheme(context),
                theme: AppTheme.lightTheme(context),
                //Classe com as Locales permitidas no app
                supportedLocales: L10n.all,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  //Tradução de elementos dentro dos widgets
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  //Para aceitar idiomas com escrita para esquerda e para direita
                  GlobalWidgetsLocalizations.delegate,
                ],
                initialRoute: '/welcome',
                onGenerateRoute: Routes.router.generator);
          },
        );
      },
    );
  }
}



/*
#Hosting Firebase
flutter build web
firebase deploy --only hosting:reservaai-app


#Mobx
flutter packages run build_runner clean
flutter packages run build_runner build
flutter packages run build_runner build --delete-conflicting-outputs
flutter packages run build_runner watch


*/
