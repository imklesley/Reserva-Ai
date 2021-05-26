import 'package:flutter/material.dart';
import 'package:reservaai/views/_shared/buttons/back_page_button.dart';
import 'package:reservaai/views/_shared/backgrounds/background_auth_mobile_tablet.dart';
import 'package:reservaai/views/forgot_password/components/forgot_password_form.dart';

class ForgotPasswordMobileBody extends StatelessWidget {
  const ForgotPasswordMobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        const BackgroundAuthMobileTablet(),
        const ForgotPasswordForm(),
        Positioned(
            top: _size.height <= 570
                ? 15
                : _size.height <= 640
                ? 50
                : _size.height <= 660 && _size.width < 300
                ? 60
                : _size.height <= 680?10:_size.height <= 740
                ? 20
                : 30,
            left: _size.height <= 570
                ? 10
                : _size.height <= 640
                ? 20: _size.height <= 670 && _size.width < 300?10
                : _size.height <= 740
                ? 20
                : 30,
            child: const BackPageButton())
      ],
    );
  }
}
