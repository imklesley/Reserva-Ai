import 'package:flutter/material.dart';
import 'package:reservaai/config/themes/app_colors.dart';

//TODO: Refatorar esse botão, criar a classe

Widget customElevatedButton({required String text,
  Color color = Colors.white,
  double fontSize = 20,
  FontWeight fontWeight = FontWeight.w400,
  Function()? onPressed,
  Color backgroundColor = AppColors.acentColor,
  double height = 50,
  double width = 230}) {
  return SizedBox(
    height: height,
    width: width,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(

        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        primary: backgroundColor,
      ),
      onPressed: onPressed,

      child: Text(text,
          style: TextStyle(
              color: color, fontWeight: fontWeight, fontSize: fontSize)),
    ),
  );
}