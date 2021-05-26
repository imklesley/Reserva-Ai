import 'package:flutter/material.dart';
import 'package:reservaai/views/_shared/backgrounds/background_auth_mobile_tablet.dart';
import 'package:reservaai/views/_shared/buttons/back_page_button.dart';
import 'package:reservaai/views/login/components/buttons/forgot_password_button.dart';
import 'package:reservaai/views/login/components/login_form.dart';

class LoginTabletBody extends StatelessWidget {
  const LoginTabletBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        const BackgroundAuthMobileTablet(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: LoginForm()
            ),
            if (_size.height >= 700) const ForgotPasswordButton() else Container()
          ],
        ),
        const Positioned(top: 30,left: 30,child: BackPageButton())
      ],
    );
  }
}
