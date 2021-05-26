import 'package:flutter/material.dart';
import 'package:reservaai/views/welcome/components/welcome_top_page.dart';
import 'package:reservaai/views/welcome/components/welcome_nav_buttons.dart';

class WelcomeMobileBody extends StatelessWidget {
  const WelcomeMobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height,
              color: Colors.transparent,
            ),
            WelcomeTopPage(size: size),
            Positioned(
                bottom: size.height * 0.02  ,
                right: 0,
                left: 0,
                child: welcomeNavButtons(context)
            ),
          ],
        ));

  }
}
