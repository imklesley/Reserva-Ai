import 'package:brasil_fields/brasil_fields.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/config/themes/app_sizes.dart';
import 'package:reservaai/controllers/stores/register_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';
import 'package:reservaai/views/register/components/buttons/already_registered_button.dart';

class PageTwoForm extends StatelessWidget {
  final Image logoReservaAi;
  final PageController pageController;
  final Size size;

  const PageTwoForm(
      {Key? key,
      required this.logoReservaAi,
      required this.pageController,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appLocalizations = AppLocalizations.of(context);

    final GlobalKey<FormState> _formKeyPageTwo = GlobalKey<FormState>();

    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    final register = Provider.of<RegisterStore>(context);

    bool isDateValid(String birthDate) {
      if (birthDate.isEmpty) {
        return false;
      } else if (birthDate.length < 10) {
        return false;
      } else {
        try {
          //Se der erro na conversão, significa a estrutura e quantidade de caracteres está errada
          final date = DateFormat('dd/MM/yyyy').parse(birthDate);

          //Verificase se a data restruturadaa  é igual à
          // que entrou, ou sejaa veerifica-se se o dart
          // não mudou a data. No dart, 01/13/2020 == 01/01/202'1'
          if (birthDate ==
              '${date.day < 10 ? '0${date.day}' : date.day}/${date.month < 10 ? '0${date.month}' : date.month}/${date.year < 10 ? '0${date.year}' : date.year}') {
            return true;
          } else {
            return false;
          }
        } catch (e) {
          return false;
        }
      }
    }

    return FittedBox(
      fit: BoxFit.fitHeight,
      //TODO: a parte do container pode virar um módulo BackgroundWhiteForm -- Verificar como tá na parte desktop
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
                    Text(
                      _appLocalizations!.fillTheFields,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
                Form(
                  key: _formKeyPageTwo,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: register.name,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              prefix: Container(
                                width: 36,
                                height: 36,
                                padding:
                                    const EdgeInsets.only(right: 10, top: 10),
                                child: const FaIcon(FontAwesomeIcons.userAlt,
                                    color: AppColors.primaryColor),
                              ),
                              labelText: _appLocalizations.fullName,
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
                          validator: (name) {
                            if (name!.isEmpty || name.split(' ').length < 2) {
                              return _appLocalizations.enterFullName;
                            }
                          },
                          onChanged: (name) {
                            register.setName(name);
                          },
                        ),
                        TextFormField(
                          initialValue: register.cpf,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            hintText: '999.999.999-99',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefix: Container(
                              width: 36,
                              height: 36,
                              padding:
                                  const EdgeInsets.only(right: 10, top: 10),
                              child: const FaIcon(
                                FontAwesomeIcons.idBadge,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            labelText: _appLocalizations.cpf,
                            labelStyle: const TextStyle(
                                fontSize: 20, color: AppColors.primaryColor),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor)),
                          ),
                          style: const TextStyle(
                              color: AppColors.primaryColor, fontSize: 20),
                          validator: (cpf) {
                            if (cpf!.isEmpty) {
                              return _appLocalizations.enterCpf;
                            }
                            if (!CPFValidator.isValid(cpf)) {
                              return _appLocalizations.invalidCpf;
                            }
                          },
                          onChanged: (cpf) {
                            register.setCpf(cpf);
                          },
                        ),
                        TextFormField(
                          initialValue: register.birthDate == null
                              ? ''
                              : '${register.birthDate!.day < 10 ? '0${register.birthDate!.day}' : register.birthDate!.day}/${register.birthDate!.month < 10 ? '0${register.birthDate!.month}' : register.birthDate!.month}/${register.birthDate!.year < 10 ? '0${register.birthDate!.year}' : register.birthDate!.year}',
                          keyboardType: TextInputType.datetime,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            DataInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            hintText: '21/10/1997',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefix: Container(
                              width: 36,
                              height: 36,
                              padding:
                                  const EdgeInsets.only(right: 10, top: 10),
                              child: const FaIcon(
                                FontAwesomeIcons.birthdayCake,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            labelText: _appLocalizations.birthDate,
                            labelStyle: const TextStyle(
                                fontSize: 20, color: AppColors.primaryColor),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor)),
                          ),
                          style: const TextStyle(
                              color: AppColors.primaryColor, fontSize: 20),
                          validator: (birthDate) {
                            if (birthDate!.isEmpty) {
                              return _appLocalizations.enterBirthDate;
                            } else if (birthDate.length < 10) {
                              return _appLocalizations.invalidBirthDate;
                            } else {
                              try {
                                //Se der erro na conversão, significa a estrutura e quantidade de caracteres está errada
                                final date =
                                    DateFormat('dd/MM/yyyy').parse(birthDate);

                                //Verificase se a data restruturadaa  é igual à
                                // que entrou, ou sejaa veerifica-se se o dart
                                // não mudou a data. No dart, 01/13/2020 == 01/01/202'1'
                                if (birthDate !=
                                    '${date.day < 10 ? '0${date.day}' : date.day}/${date.month < 10 ? '0${date.month}' : date.month}/${date.year < 10 ? '0${date.year}' : date.year}') {
                                  return _appLocalizations.invalidBirthDate;
                                }
                              } catch (e) {
                                return _appLocalizations.invalidBirthDate;
                              }
                            }
                          },
                          onChanged: (birthDate) {
                            if (isDateValid(birthDate)) {
                              //Forma elegante de trabalhar com strings to datetime :)
                              register.setBirthDate(
                                  DateFormat('dd/mm/yyyy').parse(birthDate));
                            }
                          },
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
                                    if (_formKeyPageTwo.currentState!
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
