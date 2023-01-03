import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String textButton;
  VoidCallback onPressed;

  DialogButton(this.textButton, this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(textButton),
      color: Theme.of(context).primaryColor,
    );
  }
}
