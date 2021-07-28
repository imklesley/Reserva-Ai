import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/config/themes/app_sizes.dart';
import 'package:reservaai/controllers/stores/auth_store.dart';
import 'package:reservaai/controllers/stores/login_store.dart';
import 'package:reservaai/views/_shared/buttons/login_with_facebook_button.dart';
import 'package:reservaai/views/_shared/buttons/login_with_google_button.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';
import 'package:reservaai/views/login/components/buttons/forgot_password_button.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    final LoginStore login = LoginStore();

    final _auth = Provider.of<AuthStore>(context);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    final Size _size = MediaQuery.of(context).size;

    void onSuccess(String userFirstName) {
      //TODO: Translations
      final String msg = '$userFirstName, seja bem vindo de volta!';
      final SnackBar snackBar = SnackBar(
        content: Text(
          msg,
          textAlign: isMobile ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 15 : 20,
          ),
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

      //uso a chave "_scaffoldKey" que criei e coloquei dentro do scaffold para exibir na minha tela
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacementNamed(context, '/');
    }

    void onFail(String codeError) {
      String? msg;
      //TODO: Criar translations
      if (codeError == 'user-not-found') {
        msg = 'O email informado não está cadastrado!';
      } else if (codeError == 'wrong-password') {
        msg = 'Senha Inválida! Tente Novamente!';
      } else if (codeError == 'too-many-requests') {
        msg =
            'Muitas tentativas falhas! Aguarde alguns instantes e tente novamente.';
      } else {
        msg = 'A operação falhou. Tente mais tarde!';
      }

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

    void onSuccessGoogle(String userFirstName) {
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

    void onFailGoogle(String codeError) {
      String? msg;
      //TODO: Criar translations

      if (codeError == 'account-exists-with-different-credential') {
        msg = 'Esta conta já existe!';
      } else if (codeError == 'invalid-credential') {
        msg = 'Credenciais Inválidas!';
      } else {
        msg = 'ADICIONAR ERRO "$codeError" À LISTA';
      }

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
          child: Observer(builder: (_) {
            if (_auth.isLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.acentColor),
                backgroundColor: AppColors.primaryColor,
              ));
            } else {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 5, right: 5, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/images/logo/laranja-azul.png',
                            fit: BoxFit.cover,
                            height: isMobile
                                ? 50
                                : isTablet
                                    ? 60
                                    : 70),
                        Text(
                          appLocalizations!.welcomeBack,
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  hintText: 'user@gmail.com',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  prefix: Container(
                                    width: 36,
                                    height: 36,
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 10),
                                    child: const FaIcon(
                                        FontAwesomeIcons.userAlt,
                                        color: AppColors.primaryColor),
                                  ),
                                  labelText: appLocalizations.email,
                                  labelStyle: const TextStyle(
                                      fontSize: 20,
                                      color: AppColors.primaryColor),
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
                                  return appLocalizations.enterEmail;
                                } else if (!isEmail(email)) {
                                  return appLocalizations.invalidEmail;
                                }
                              },
                              onChanged: login.setEmail,
                              onFieldSubmitted: (value) {
                                //Salvar form via ENTER KEY''
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                }
                              },
                            ),
                            Observer(
                              builder: (BuildContext context) {
                                return TextFormField(
                                  obscureText: login.obscureText,
                                  keyboardType: TextInputType.visiblePassword,
                                  cursorColor: AppColors.primaryColor,
                                  decoration: InputDecoration(
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
                                      labelText: appLocalizations.password,
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
                                              login.toggleObscureText();
                                            },
                                            icon: FaIcon(
                                                login.obscureText
                                                    ? FontAwesomeIcons.eyeSlash
                                                    : FontAwesomeIcons.eye,
                                                color: AppColors.primaryColor),
                                          ))),
                                  style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 20),
                                  validator: (password) {
                                    if (password!.isEmpty) {
                                      return appLocalizations.enterPassword;
                                    }
                                  },
                                  onChanged: (value) {
                                    login.setPassword(value);
                                  },
                                  onFieldSubmitted: (value) {
                                    //Salvar form via ENTER KEY

                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: isMobile || isTablet ? 40 : 45,
                            ),
                            SizedBox(
                              height: isMobile ? 40 : 60,
                              width: isMobile ? 150 : 200,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _auth.signInWithEmailAndPassword(
                                          email: login.email,
                                          password: login.password,
                                          onSuccess: onSuccess,
                                          onFail: onFail);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(elevation: 2),
                                  child: Text(appLocalizations.signIn,
                                      style: const TextStyle(
                                          color: Colors.white))),
                            ),
                            SizedBox(
                              height: isMobile || isTablet ? 20 : 40,
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    appLocalizations.or,
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
                                if (_size.height < 700)
                                  const ForgotPasswordButton(
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
              );
            }
          })),
    );
  }
}
