import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BackPageButton extends StatelessWidget {
  const BackPageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Container(
      decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
        iconSize: 25,
        // padding: EdgeInsets.zero,
        alignment: Alignment.centerLeft,
        tooltip: appLocalizations!.back,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

/*
* _size.height <= 640 && _size.width <= 366
          ? EdgeInsets.fromLTRB(0, 0, 20, 15)
          : _size.height <= 640 && _size.width <=384 ?EdgeInsets.fromLTRB(20, 50, 20, 15):


      _size.height <= 700
              ? EdgeInsets.fromLTRB(20, 65, 20, 15)
              : _size.height <=730?EdgeInsets.fromLTRB(25, 80, 20, 15) :EdgeInsets.all(30),*/
