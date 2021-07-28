import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const AdaptiveText({Key? key, required this.text, required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return SelectableText(
        text,
        style: style,
      );
    }

    return Text(
      text,
      style: style,
    );
  }
}
