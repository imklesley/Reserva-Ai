import 'package:flutter/material.dart';
import 'package:reservaai/views/_shared/buttons/back_page_button.dart';
import 'package:reservaai/views/_shared/backgrounds/background_auth_mobile_tablet.dart';
import 'package:reservaai/views/forgot_password/components/forgot_password_form.dart';

class ForgotPasswordTabletBody extends StatelessWidget {
  const ForgotPasswordTabletBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: const [
         BackgroundAuthMobileTablet(),
         ForgotPasswordForm(),
         Positioned(top: 30,left: 30,child: BackPageButton())
      ],
    );
  }
}
