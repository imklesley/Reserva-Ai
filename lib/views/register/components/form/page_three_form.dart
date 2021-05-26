import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/config/themes/app_sizes.dart';
import 'package:reservaai/controllers/stores/register_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';
import 'package:reservaai/views/register/components/buttons/already_registered_button.dart';

class PageThreeForm extends StatelessWidget {
  final Image logoReservaAi;
  final PageController pageController;
  final Size size;

  const PageThreeForm(
      {Key? key,
      required this.logoReservaAi,
      required this.pageController,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appLocalizations = AppLocalizations.of(context);

    final GlobalKey<FormState> _formKeyPageThree = GlobalKey<FormState>();

    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    final register = Provider.of<RegisterStore>(context);


    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Container(
          height: isMobile
              ? 538
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
              borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.defaultRadiusContainer))),
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    logoReservaAi,
                    Text(
                      _appLocalizations!.fillTheFields,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
                Form(
                  key: _formKeyPageThree,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: register.gender,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              labelText: 'Gender',
                              labelStyle: const TextStyle(
                                  fontSize: 20, color: AppColors.primaryColor),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor))),
                          style: const TextStyle(
                              color: AppColors.primaryColor, fontSize: 20),
                          validator: (gender){
                            if(gender!.isEmpty)
                              return 'Choose you gender!';
                          },
                          onChanged: (gender) {
                            register.setGender(gender);
                          },

                        ),
                        TextFormField(
                          initialValue: register.phoneNumber,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                          decoration: InputDecoration(
                              prefix: Container(
                                width: 36,
                                height: 36,
                                padding:
                                    const EdgeInsets.only(right: 10, top: 10),
                                child: const FaIcon(FontAwesomeIcons.phone,
                                    color: AppColors.primaryColor),
                              ),
                              labelText: _appLocalizations.phone,
                              labelStyle: const TextStyle(
                                  fontSize: 20, color: AppColors.primaryColor),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor))),
                          style: const TextStyle(
                              color: AppColors.primaryColor, fontSize: 20),
                          onChanged: (phone) {
                            register.setPhoneNumber(phone);
                          },
                          validator: (phone) {
                            if (phone!.isEmpty) {
                              return _appLocalizations.enterPhoneNumber;
                            } else if (phone.length < 15) {
                              return _appLocalizations.invalidPhoneNumber;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _appLocalizations
                                    .bookingNotificationsUsingWhatsapp,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryColor),
                              ),
                              Observer(builder: (_) {
                                return FlutterSwitch(
                                  value: register.isWhatsapp,
                                  onToggle: (value) {
                                    register.toggleIsWhatsapp();
                                  },
                                  activeColor: Colors.green,
                                  activeText: 'On',
                                  activeTextColor: Colors.white,
                                  inactiveText: 'Off',
                                  inactiveTextColor: Colors.white,
                                  activeIcon: const FaIcon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.green,
                                  ),
                                  inactiveIcon: const FaIcon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.grey,
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                        const Divider(
                          height: 2,
                          thickness: 1,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          height: isMobile || isTablet ? 40 : 45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: isMobile ? 40 : 60,
                              width: isMobile ? 120 : 180,
                              child: ElevatedButton(
                                  onPressed: () {
                                    pageController.previousPage(
                                        duration:
                                        const Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                    FocusScope.of(context).unfocus();


                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColors.primaryColor,
                                      elevation: 2),
                                  child: Text(_appLocalizations.previous,
                                      style: const TextStyle(
                                          color: Colors.white))),
                            ),
                            SizedBox(
                              height: isMobile ? 40 : 60,
                              width: isMobile ? 120 : 180,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKeyPageThree.currentState!
                                        .validate()) {
                                      pageController.nextPage(
                                          duration:
                                          const Duration(milliseconds: 200),
                                          curve: Curves.easeIn);
                                      FocusScope.of(context).unfocus();


                                    }
                                  },
                                  style: ElevatedButton.styleFrom(elevation: 2),
                                  child: Text(_appLocalizations.next,
                                      style: const TextStyle(
                                          color: Colors.white))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: isMobile || isTablet ? 20 : 40,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (size.height < 700)
                          const AlreadyRegistered(
                            color: AppColors.acentColor,
                          )
                        else
                          Container()
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
