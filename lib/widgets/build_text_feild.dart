import 'package:flutter/material.dart';

Widget buildFormField({
  required TextEditingController controller,
  required String labelText,
  required IconData icon,
  TextInputType? keyboardType,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
      ),
      keyboardType: keyboardType,
    ),
  );
}
