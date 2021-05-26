
import 'package:flutter/material.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/config/themes/app_sizes.dart';
import 'package:reservaai/views/_shared/buttons/back_page_button.dart';
import 'package:reservaai/views/forgot_password/components/forgot_password_form.dart';


class ForgotPasswordDesktopBody extends StatelessWidget {
  const ForgotPasswordDesktopBody({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Container(
      color: AppColors.acentColor,
      height: _size.height,
      width: _size.width,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  width: _size.width/2,
                  height: _size.height,
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight:
                        Radius.circular(AppSizes.defaultRadiusContainer),
                        bottomRight:
                        Radius.circular(AppSizes.defaultRadiusContainer),
                      )),child: Center(
                    child: Image.asset(
                      'assets/images/logo/branco-laranja.png',
                      fit: BoxFit.cover,
                    )),
                ),
                const Positioned(top: 30,left: 30,child: BackPageButton())
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: AppColors.acentColor,
              width: _size.width/2,
              height: _size.height,
              child: const Center(child: ForgotPasswordForm()),
            ),
          )
        ],
      ),
    );
  }
}
