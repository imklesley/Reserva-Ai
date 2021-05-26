import 'package:flutter/material.dart';
import 'package:reservaai/config/themes/app_colors.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlreadyRegistered extends StatelessWidget {
  final Color color;

  const AlreadyRegistered({Key? key, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final bool isMobile = ResponsiveLayout.isMobile(context);

    return SizedBox(
      width: 200,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.black12)),
        child: Text(
          appLocalizations!.alreadyRegistered,
          style: TextStyle(
              color: color,
              fontSize: isMobile ? 15 : 18,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
