import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:reservaai/config/router/route_names.dart';
import 'package:reservaai/views/forgot_password/forgot_password_view.dart';
import 'package:reservaai/views/home/home_view.dart';
import 'package:reservaai/views/login/login_view.dart';
import 'package:reservaai/views/page_404/page_404_view.dart';
import 'package:reservaai/views/register/register_view.dart';

import 'package:reservaai/views/welcome/welcome_view.dart';

// ignore: avoid_classes_with_only_static_members
class Routes {
  //Instância Fluro
  static final FluroRouter router = FluroRouter();

  // Handler de rota padrão -- view sem params
  static Handler _defaultHandler(Widget view) {
    return Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return view;
    });
  }

  //----------  Ações realizadas em cada rota  ----------//

  static final Handler _welcomeHandler = _defaultHandler(const WelcomeView());

  static final Handler _homeHandler = _defaultHandler(const HomeView());

  static final Handler _loginHandler = _defaultHandler(const LoginView());

  static final Handler _registerHandler = _defaultHandler(const RegisterView());
  static final Handler _forgotPasswordHandler =
      _defaultHandler(const ForgotPasswordView());

  //----------  Viculação de rotas com suas respectivas ações  ----------//
  static void setupRouter() {
    // 404 - Página n encontrada
    router.notFoundHandler = Handler(
        handlerFunc: (context, Map<String, dynamic> params) => const Page404View());

    router.define(welcomeRoute,
        handler: _welcomeHandler, transitionType: TransitionType.inFromLeft);

    router.define(homeRoute, handler: _homeHandler);

    router.define(loginRoute, handler: _loginHandler);

    router.define(registerRoute, handler: _registerHandler);

    router.define(forgotPasswordRoute, handler: _forgotPasswordHandler);
  }
}
