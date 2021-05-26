import 'package:flutter/material.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';
import 'package:reservaai/views/login/components/bodys/login_desktop_body.dart';
import 'package:reservaai/views/login/components/bodys/login_mobile_body.dart';
import 'package:reservaai/views/login/components/bodys/login_tablet_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: ResponsiveLayout(
            mobileBody: LoginMobileBody(),
            tabletBody: LoginTabletBody(),
            desktopBody: LoginDesktopBody(),
          ),
        ));
  }
}
