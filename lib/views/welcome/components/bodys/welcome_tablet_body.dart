import 'package:flutter/material.dart';

import 'package:reservaai/views/welcome/components/welcome_top_page.dart';
import 'package:reservaai/views/welcome/components/welcome_nav_buttons.dart';

class WelcomeTabletBody extends StatelessWidget {
  const WelcomeTabletBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Row(
          children: [
            Expanded(child: WelcomeTopPage(size: size)),
            Expanded(
              child: welcomeNavButtons(context),
            ),
          ],
        ));
  }
}
