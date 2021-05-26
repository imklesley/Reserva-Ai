import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/controllers/stores/auth_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';

class LoginWithGoogleButton extends StatelessWidget {
  final BuildContext formContext;

  const LoginWithGoogleButton({Key? key, required this.formContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthStore>(context);
    final appLocalizations = AppLocalizations.of(context);
    final bool isMobile = ResponsiveLayout.isMobile(context);

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

      ScaffoldMessenger.of(formContext).showSnackBar(snackBar);
      Navigator.pushReplacementNamed(formContext, '/');
    }

    void onFail(String codeError) {
      String? msg;
      //TODO: Criar translations

      if (codeError == 'account-exists-with-different-credential') {
        msg = 'Esta conta já existe com credenciais diferentes!';
      } else if (codeError == 'invalid-credential') {
        msg = 'Credenciais Inválidas!';
      } else if(codeError == 'popup-closed-by-user') {
        msg = 'Você cancelou o login. Tente Novamente!';
      } else {
        //Caso ocorra algum erro n previsto
        msg = 'Ocorreu o erro:"$codeError"';
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

      ScaffoldMessenger.of(formContext).showSnackBar(snackBar);
    }

    return Tooltip(
      message: appLocalizations!.signInWithGoogle,
      textStyle: const TextStyle(color: AppColors.acentColor, fontSize: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          elevation: 3,
        ),
        onPressed: () {
          _auth.signInWithGoogle(onSuccess: onSuccess, onFail: onFail);
        },
        child: SizedBox(
          height: 50,
          child: SvgPicture.asset('assets/images/icons/google_logo.svg',
              semanticsLabel: 'Google Logo Sign In / Sign Up',
              height: 20,
              width: 20),
        ),
      ),
    );
  }
}
