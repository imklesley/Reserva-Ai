import 'package:flutter/material.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/config/themes/app_sizes.dart';

class BackgroundAuthMobileTablet extends StatelessWidget {
  const BackgroundAuthMobileTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Container(
      color: AppColors.acentColor,
      height: _size.height,
      width: _size.width,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: _size.width,
              height: _size.height/2,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.circular(AppSizes.defaultRadiusContainer),
                    bottomRight:
                        Radius.circular(AppSizes.defaultRadiusContainer),
                  )),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: AppColors.acentColor,
              width: _size.width,
              height: _size.height/2,
            ),
          )
        ],
      ),
    );
  }
}
