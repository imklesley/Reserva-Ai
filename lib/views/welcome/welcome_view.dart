import 'package:flutter/material.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';

import 'components/bodys/welcome_desktop_body.dart';
import 'components/bodys/welcome_mobile_body.dart';
import 'components/bodys/welcome_tablet_body.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ResponsiveLayout(
            mobileBody: WelcomeMobileBody(),
            tabletBody: WelcomeTabletBody(),
            desktopBody: WelcomeDesktopBody(),
          ),
        ),
      ),
    );
  }
}
