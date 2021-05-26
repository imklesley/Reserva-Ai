import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/config/themes/app_sizes.dart';
import 'package:reservaai/controllers/stores/auth_store.dart';
import 'package:reservaai/controllers/stores/register_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';
import 'package:reservaai/views/register/components/buttons/already_registered_button.dart';

class PageFourForm extends StatefulWidget {
  final Image logoReservaAi;
  final PageController pageController;
  final Size size;

  const PageFourForm({
    Key? key,
    required this.logoReservaAi,
    required this.pageController,
    required this.size,
  }) : super(key: key);

  @override
  _PageFourFormState createState() => _PageFourFormState();
}

class _PageFourFormState extends State<PageFourForm> {
  @override
  Widget build(BuildContext context) {
    final _appLocalizations = AppLocalizations.of(context);

    final _auth = Provider.of<AuthStore>(context);

    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    final register = Provider.of<RegisterStore>(context);

    final ImagePicker _picker = ImagePicker();

    void onSuccess(String userFirstName) {
      //TODO: Translations
      final String msg = '$userFirstName, seja bem vindo!';

      //Instaciei uma snackbar
      final SnackBar snackBar = SnackBar(
        content: Text(
          msg,
          textAlign: isMobile ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 15 : 20,
          ),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        //formato arredondado da snackbar
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacementNamed(context, '/');
    }

    void onFail(String codeError) {
      String? msg;
      //TODO: Criar translations
      if (codeError == 'email-already-in-use') {
        msg = 'O e-mail informado já está em uso em outra conta!';
      } else if (codeError == 'weak-password') {
        msg = 'Sua senha é fraca. Por favor coloque mais caracteres e/ou caracteres especiais como #, ! e @ ';
      } else {
        msg = 'A operação falhou. Tente mais tarde!';
      }

      //Caso tenha dado algo erro, foi na página 0, logo já mando o user para essa página
      widget.pageController.jumpToPage(0);

      //Exibição de snackbar com a mensagem
      final SnackBar snackBar = SnackBar(
        content: Text(
          msg,
          textAlign: isMobile ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 15 : 20,
          ),
        ),
        backgroundColor: Colors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        duration: const Duration(seconds: 3),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

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
          child: Observer(
            builder: (BuildContext context) {
              if (_auth.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.primaryColor,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.acentColor),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 5, right: 5, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          widget.logoReservaAi,
                          const Text(
                            'Take a picture of this beautiful face!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: GestureDetector(
                          onTap: () async {
                            final PickedFile? picked = await _picker.getImage(
                                source: ImageSource.camera);
                            if (picked != null) {
                              register.setProfilePicture(picked);
                            }
                          },
                          child: Tooltip(
                              message: 'Take a picture',
                              child: Observer(
                                builder: (BuildContext context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (register.profilePicture == null)
                                        const SizedBox(
                                          height: 200,
                                          width: 200,
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  AppColors.primaryColorLighter,
                                              child: Icon(
                                                Icons.person,
                                                size: 120,
                                                color: Colors.white,
                                              )),
                                        )
                                      else
                                        !kIsWeb
                                            ? Container(
                                                width: 200,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: FileImage(File(
                                                            register
                                                                .profilePicture!
                                                                .path)),
                                                        fit: BoxFit.cover)),
                                              )
                                            : Container(
                                                width: 200,
                                                height: 200,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          300),
                                                  child: Image.network(
                                                    register
                                                        .profilePicture!.path,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'Take a picture',
                                        style: TextStyle(
                                            color: AppColors.primaryColor),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 100, right: 100),
                                        child: Divider(
                                          height: 1,
                                          color: AppColors.primaryColor,
                                          thickness: 1,
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: isMobile ? 40 : 60,
                            width: isMobile ? 120 : 180,
                            child: ElevatedButton(
                                onPressed: () {
                                  widget.pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: AppColors.primaryColor,
                                    elevation: 2),
                                child: Text(_appLocalizations!.previous,
                                    style:
                                        const TextStyle(color: Colors.white))),
                          ),
                          SizedBox(
                            height: isMobile ? 40 : 60,
                            width: isMobile ? 120 : 180,
                            child: ElevatedButton(
                                onPressed: () async {
                                  final Map<String, dynamic> userData = {
                                    'account_created': Timestamp.now(),
                                    'birth_date':
                                        Timestamp.fromDate(register.birthDate!),
                                    'contact': {
                                      'number': register.phoneNumber,
                                      'is_whatsapp': register.isWhatsapp,
                                    },
                                    'cpf': register.cpf,
                                    'email': register.email,
                                    'gender': register.gender,
                                    //Na criação é sempre o tempo atual
                                    'last_access': Timestamp.now(),
                                    'location': register.location,
                                    'name': register.name,
                                    'profile_picture': register.profilePicture != null? await register
                                        .profilePicture!
                                        .readAsBytes():null,
                                    //Verificar quais outras configurações entram aqui
                                    'settings': {
                                      'email_subscription': true,
                                    }
                                  };

                                  _auth.signUpWithEmailAndPassword(
                                      userData: userData,
                                      password: register.password,
                                      onSuccess: onSuccess,
                                      onFail: onFail);
                                },
                                style: ElevatedButton.styleFrom(elevation: 2),
                                child: const Text('Finish',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: isMobile || isTablet ? 20 : 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (widget.size.height < 700)
                        const AlreadyRegistered(
                          color: AppColors.acentColor,
                        )
                      else
                        Container()
                    ],
                  ),
                );
              }
            },
          )),
    );
  }
}
