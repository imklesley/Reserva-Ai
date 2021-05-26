import 'package:flutter/material.dart';
import 'package:reservaai/views/_shared/backgrounds/background_auth_mobile_tablet.dart';
import 'package:reservaai/views/_shared/buttons/back_page_button.dart';
import 'package:reservaai/views/register/components/buttons/already_registered_button.dart';
import 'package:reservaai/views/register/components/form/register_form.dart';

class RegisterTabletBody extends StatelessWidget {
  const RegisterTabletBody({Key? key}) : super(key: key);

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
            const Center(child: RegisterForm()),
            if (_size.height >= 700) const AlreadyRegistered() else Container()
          ],
        ),
        const Positioned(top: 30,left: 30,child: BackPageButton())
      ],
    );
  }
}
