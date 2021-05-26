

import 'package:flutter/material.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';

import 'components/bodys/register_desktop_body.dart';
import 'components/bodys/register_mobile_body.dart';
import 'components/bodys/register_tablet_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: ResponsiveLayout(
            mobileBody: RegisterMobileBody(),
            tabletBody: RegisterTabletBody(),
            desktopBody: RegisterDesktopBody(),
          ),
        ));
  }
}
