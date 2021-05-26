import 'package:flutter/material.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';

class RichTextLogo extends StatelessWidget {
  const RichTextLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: 'Reserva ',
          style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,
              fontSize:
              !(isMobile || isTablet) ? 60 : 30,
              color: Colors.white,
              fontWeight: FontWeight.w800),
        ),
        TextSpan(
          text: 'Aí ',
          style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,
              fontSize:
              !(isMobile || isTablet) ? 60 : 30,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w800),
        ),
        TextSpan(
          text: '!',
          style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,

              fontSize:
              !(isMobile || isTablet) ? 60 : 30,
              color: Colors.white,
              fontWeight: FontWeight.w800),
        ),
      ]),
    );
  }
}
