import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  ///var
  final String? title;
  final void Function()? onPressed;

  ///const
  const CustomButton({
    super.key,
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.red,
      onPressed: onPressed,
      textColor: Colors.white,
      child: Center(child: Text(title.toString())),
    );
  }
}
