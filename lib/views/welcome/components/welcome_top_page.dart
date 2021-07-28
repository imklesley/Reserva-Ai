import 'package:flutter/material.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/config/themes/app_sizes.dart';
import 'package:reservaai/views/_shared/adaptive_text.dart';
import 'package:reservaai/views/_shared/buttons/back_page_button.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservaai/views/_shared/rich_text_logo.dart';

class WelcomeTopPage extends StatelessWidget {
  final Size size;

  const WelcomeTopPage({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    return Stack(
      children: [
        if (!isMobile)
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight:
                          Radius.circular(AppSizes.defaultRadiusContainer),
                      bottomRight:
                          Radius.circular(AppSizes.defaultRadiusContainer)),
                  child: Image.asset(
                    'assets/images/context/restaurant_welcome_page.jpg',
                    semanticLabel:
                        'Pessoas em um restaurante como plano de fundo',
                    fit: BoxFit.cover,
                    height: size.height,
                  )))
        else
          Container(),
        FittedBox(
          child: Opacity(
            opacity: 0.9,
            child: Container(
              width: isMobile ? size.width : size.width / 2,
              height: !isMobile ? size.height : null,
              decoration: BoxDecoration(
                  color: AppColors.acentColor,
                  borderRadius: isMobile
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        )
                      : const BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        )),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: isMobile || isTablet
                              ? const EdgeInsets.only(
                                  //top:60 para sair debaixo do BackPageButton
                                  top: 80,
                                  left: 40,
                                  right: 40,
                                  bottom: 20)
                              : const EdgeInsets.only(
                                  top: 70, left: 100, right: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const RichTextLogo(),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: !(isMobile || isTablet) ? 100 : 45,
                                  bottom: !(isMobile || isTablet) ? 100 : 45,
                                ),
                                child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: AdaptiveText(
                                      text: appLocalizations!.helloWelcome,
                                      style: TextStyle(
                                          fontSize: isMobile
                                              ? 45
                                              : isTablet
                                                  ? 65
                                                  : 75,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    )),
                              ),
                              FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: AdaptiveText(
                                    text: appLocalizations.reservaaiSlogan,
                                    style: TextStyle(
                                        fontSize: isMobile
                                            ? 20
                                            : isTablet
                                                ? 20
                                                : 35,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          )),
                    ],
                  ),
                  const Positioned(top: 30, left: 30, child: BackPageButton()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
