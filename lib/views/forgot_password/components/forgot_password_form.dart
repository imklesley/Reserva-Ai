import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/config/themes/app_sizes.dart';
import 'package:reservaai/controllers/stores/auth_store.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    final _auth = Provider.of<AuthStore>(context);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    final TextEditingController _emailController = TextEditingController();

    return Container(
      height: isMobile
          ? 550
          : isTablet
              ? 600
              : 650,
      width: isMobile
          ? 360
          : isTablet
              ? 530
              : 600,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(AppSizes.defaultRadiusContainer)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Image.asset('assets/images/logo/laranja-azul.png',
                  fit: BoxFit.cover,
                  height: isMobile
                      ? 50
                      : isTablet
                      ? 60
                      : 70),
              Text(
                appLocalizations!.letUsHelpYou,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    decoration: TextDecoration.none),
              ),
            ],),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'user@gmail.com',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefix: Container(
                            width: 36,
                            height: 36,
                            padding: const EdgeInsets.only(right: 10, top: 10),
                            child: const FaIcon(FontAwesomeIcons.userAlt,
                                color: AppColors.primaryColor),
                          ),
                          labelText: appLocalizations.email,
                          labelStyle: const TextStyle(
                              fontSize: 20, color: AppColors.primaryColor),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor)),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor))),
                      style: const TextStyle(
                          color: AppColors.primaryColor, fontSize: 20),
                      validator: (email) {
                        if (email!.isEmpty) {
                          return appLocalizations.enterEmail;
                        } else if (!isEmail(email)) {
                          return appLocalizations.invalidEmail;
                        }
                      },
                    ),
                    SizedBox(
                      height: isMobile || isTablet ? 45 : 50,
                    ),
                    SizedBox(
                      height: isMobile ? 40 : 60,
                      width: isMobile ? 160 : 200,
                      child: ElevatedButton(
                          onPressed: () {

                            if (_formKey.currentState!.validate()) {
                              _auth.recoverPassword(
                                  email: _emailController.text);
                              //Instaciei uma snackbar
                              final SnackBar snackBar = SnackBar(
                                content: Text(
                                  appLocalizations.recoveryLinkHasBeenSent,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 3),
                                //formato arredondado da snackbar
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.0),
                                    topRight: Radius.circular(12.0),
                                  ),
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              Navigator.pushReplacementNamed(context, '/login');
                            }
                          },
                          style: ElevatedButton.styleFrom(elevation: 2),
                          child: Text(appLocalizations.recoverPassword,
                              style: TextStyle(color: Colors.white,fontSize: isMobile?15:isTablet?18:20))),
                    ),
                    SizedBox(
                      height: isMobile || isTablet ? 20 : 40,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
