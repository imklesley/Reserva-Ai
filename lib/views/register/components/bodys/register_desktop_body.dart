import 'package:flutter/material.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/config/themes/app_sizes.dart';
import 'package:reservaai/views/_shared/buttons/back_page_button.dart';
import 'package:reservaai/views/register/components/buttons/already_registered_button.dart';
import 'package:reservaai/views/register/components/form/register_form.dart';

class RegisterDesktopBody extends StatelessWidget {
  const RegisterDesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          width: _size.width / 2,
          height: _size.height,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)),
          ),
          child: Stack(
            children: [
              Center(
                  child: Image.asset(
                'assets/images/logo/branco-laranja.png',
                fit: BoxFit.cover,
              )),
              const Padding(
                padding: EdgeInsets.all(AppSizes.defaultPadding),
                child: BackPageButton(),
              )
            ],
          ),
        ),
        Container(
            color: AppColors.acentColor,
            width: _size.width / 2,
            height: _size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RegisterForm(),
                const SizedBox(
                  height: 30,
                ),
                if (_size.height >= 700) const AlreadyRegistered() else Container()
              ],
            )),
      ],
    );
  }
}
