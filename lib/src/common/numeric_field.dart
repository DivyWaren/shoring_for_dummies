import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildNumericField(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true), // Allows decimal input
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
      ],
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    ),
  );
}
