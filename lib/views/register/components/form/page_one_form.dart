import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '/config/themes/app_colors.dart';
import '/config/themes/app_sizes.dart';
import '/controllers/stores/register_store.dart';
import '/views/_shared/buttons/login_with_facebook_button.dart';
import '/views/_shared/buttons/login_with_google_button.dart';
import '/views/_shared/responsive_layout.dart';
import '/views/register/components/buttons/already_registered_button.dart';

class PageOneForm extends StatelessWidget {
  final Image logoReservaAi;
  final PageController pageController;
  final Size size;

  const PageOneForm(
      {Key? key,
      required this.logoReservaAi,
      required this.pageController,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appLocalizations = AppLocalizations.of(context);

    final GlobalKey<FormState> _formKeyPageOne = GlobalKey<FormState>();

    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    final register = Provider.of<RegisterStore>(context);

    Future<Position> _getPosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Verifica se o serviço de localização está ligado
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        //TODO: Uma tela de "Ligue o GPS!"
        return Future.error('Location services are disabled.');
      }

      //Verifica-se as permissões de acesso
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          //TODO: Uma tela de "Para continuar você precisa nos deixar acessar sua localização"
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Tela dizendo que não podemos deixar ele continuar sem que tenha a permissão da localização
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      //Caso dê tudo certo, podemos pegar à posição do usuário em coodenadas
      return Geolocator.getCurrentPosition();
    }

    // TODO: Tratar os devidos erros caso o usuário decida n liberar a localização
    _getPosition().then((Position coords) {
      debugPrint(coords.toString());
      //insere às coods
      register.setLocation(GeoPoint(coords.latitude, coords.latitude));
    });

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
            padding:
                const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    logoReservaAi,
                    const Text(
                      'Welcome!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
                Form(
                  key: _formKeyPageOne,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          //Por alguma razão quando muda de page, os dados se perdem da interface, logo estou recuperando dos dados salvos na RegisterStore
                          initialValue: register.email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'user@gmail.com',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              prefix: Container(
                                width: 36,
                                height: 36,
                                padding:
                                    const EdgeInsets.only(right: 10, top: 10),
                                child: const FaIcon(FontAwesomeIcons.mailBulk,
                                    color: AppColors.primaryColor),
                              ),
                              labelText: _appLocalizations!.email,
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
                          validator: (email) {
                            if (email!.isEmpty) {
                              return _appLocalizations.enterEmail;
                            } else if (!isEmail(email)) {
                              return _appLocalizations.invalidEmail;
                            }
                          },
                          onChanged: (email) {
                            register.setEmail(email);
                          },
                        ),
                        Observer(
                          builder: (BuildContext context) {
                            return TextFormField(
                              initialValue: register.password,
                              obscureText: register.obscureText,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  errorMaxLines: 5,
                                  prefix: Container(
                                    width: 36,
                                    height: 36,
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 10),
                                    child: const FaIcon(
                                      FontAwesomeIcons.lock,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  labelText: _appLocalizations.password,
                                  labelStyle: const TextStyle(
                                      fontSize: 20,
                                      color: AppColors.primaryColor),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor)),
                                  suffix: Container(
                                      width: 60,
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10),
                                      child: IconButton(
                                        onPressed: () {
                                          register.toggleObscureText();
                                        },
                                        icon: FaIcon(
                                            register.obscureText
                                                ? FontAwesomeIcons.eyeSlash
                                                : FontAwesomeIcons.eye,
                                            color: AppColors.primaryColor),
                                      ))),
                              style: const TextStyle(
                                  color: AppColors.primaryColor, fontSize: 20),
                              validator: (password) {
                                if (password!.isEmpty) {
                                  return _appLocalizations.enterPassword;
                                } else if (password.length < 8 ||
                                    !(password.contains(RegExp('[0-9]')) ||
                                        !password
                                            .contains(RegExp('[a-z-A-Z]')))) {
                                  return 'A senha precisa de pelo menos 8 caracteres, letras e números!';
                                }
                                //TODO:Senha precisa ter pelo menos 8 caracteres, letras e números
                              },
                              onChanged: (value) {
                                register.setPassword(value);
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: isMobile || isTablet ? 30 : 40,
                        ),
                        SizedBox(
                          height: isMobile ? 40 : 60,
                          width: isMobile ? 150 : 200,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKeyPageOne.currentState!.validate()) {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              style: ElevatedButton.styleFrom(elevation: 2),
                              child: Text(_appLocalizations.next,
                                  style: const TextStyle(color: Colors.white))),
                        ),
                        SizedBox(
                          height: isMobile || isTablet ? 20 : 40,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                _appLocalizations.or,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  LoginWithGoogleButton(
                                    formContext: context,
                                  ),
                                  LoginWithFacebookButton(
                                    formContext: context,
                                  ),
                                  // LoginWithTwitterButton(formContext: context,),
                                ],
                              ),
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
