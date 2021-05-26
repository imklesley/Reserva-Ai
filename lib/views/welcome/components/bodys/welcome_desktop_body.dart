import 'package:flutter/material.dart';
import 'package:reservaai/views/welcome/components/welcome_top_page.dart';
import 'package:reservaai/views/welcome/components/welcome_nav_buttons.dart';

class WelcomeDesktopBody extends StatelessWidget {
  const WelcomeDesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Row(
      children: [
        Expanded(flex: 2, child: Center(child: WelcomeTopPage(size: _size))),
        Expanded(
          flex: 2,
          child: welcomeNavButtons(context),
        ),
      ],
    ));
  }
}
