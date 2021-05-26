import 'package:flutter/material.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';
import 'package:reservaai/views/forgot_password/components/bodys/forgot_password_mobile_body.dart';

import 'components/bodys/forgot_password_desktop_body.dart';
import 'components/bodys/forgot_password_tablet_body.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: ResponsiveLayout(
                mobileBody: ForgotPasswordMobileBody(),
                tabletBody: ForgotPasswordTabletBody(),
                desktopBody: ForgotPasswordDesktopBody()),
          )),
    );
  }


}
