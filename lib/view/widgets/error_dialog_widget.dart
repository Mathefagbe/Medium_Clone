import 'package:flutter/material.dart';
import '../style/colors/colorstyle.dart';

class ErrorDialogWiget extends StatelessWidget {
  final String errorMessage;
  final void Function() ontap;
  const ErrorDialogWiget(
      {super.key, required this.errorMessage, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        errorMessage,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      elevation: 1,
      backgroundColor: Theme.of(context).cardColor,
      actions: [
        TextButton(
            onPressed: ontap,
            child: Text(
              "Try again",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: ColorStyle.lightgreen),
            ))
      ],
    );
  }
}
