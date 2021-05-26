import 'package:flutter/material.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/views/_shared/buttons/custom_elevated_buttom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Widget welcomeNavButtons(BuildContext context) {
  final appLocalizations = AppLocalizations.of(context);

  return Padding(
    padding: const EdgeInsets.only(top:50),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customElevatedButton(
            text: appLocalizations!.signIn,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            }),
        const SizedBox(
          height: 10,
        ),
        customElevatedButton(
            text: appLocalizations.signUp,
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            backgroundColor: AppColors.primaryColorLighter),
      ],
    ),
  );
}
