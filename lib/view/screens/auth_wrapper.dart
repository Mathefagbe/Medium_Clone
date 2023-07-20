import 'package:dblog/view/screens/login_view.dart';
import 'package:dblog/view/screens/nav_view.dart';

// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../main.dart';

class WrapperView extends StatelessWidget {
  const WrapperView({super.key});

  @override
  Widget build(BuildContext context) {
    return basetoken == ""
        ? const LoginScreen()
        : const NavigationBottomBarView();
  }
}
