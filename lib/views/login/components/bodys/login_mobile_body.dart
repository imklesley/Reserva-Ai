import 'package:flutter/material.dart';
import 'package:reservaai/views/_shared/backgrounds/background_auth_mobile_tablet.dart';
import 'package:reservaai/views/_shared/buttons/back_page_button.dart';
import 'package:reservaai/views/login/components/buttons/forgot_password_button.dart';
import 'package:reservaai/views/login/components/login_form.dart';

class LoginMobileBody extends StatelessWidget {
  const LoginMobileBody({Key? key}) : super(key: key);

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
            Padding(
              padding:  EdgeInsets.only(top:_size.height>=700?80:0),
              child: const LoginForm(),
            ),
            if (_size.height >= 700) const ForgotPasswordButton() else Container()
          ],
        ),
        Positioned(
            top: _size.height <= 570
                ? 55
                : _size.height <= 640
                    ? 75
                    : _size.height <= 660 && _size.width < 300
                        ? 120
                        : _size.height <= 680?10:_size.height <= 740
                            ? 20
                            : 30,
            left: _size.height <= 570
                ? 10
                : _size.height <= 640
                    ? 15: _size.height <= 670 && _size.width < 300?10
                    : _size.height <= 740
                        ? 20
                        : 30,
            child: const BackPageButton())
      ],
    );
  }
}
