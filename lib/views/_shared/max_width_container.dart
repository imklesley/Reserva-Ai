import 'package:flutter/cupertino.dart';
import 'package:reservaai/config/constants/screen_breakpoints.dart';

class MaxWidthContainer extends StatelessWidget {
  final Widget child;
  const MaxWidthContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kMaxWidth),
        child: child,
      ),
    );
  }
}
