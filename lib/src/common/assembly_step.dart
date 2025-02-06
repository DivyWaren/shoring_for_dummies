import 'package:flutter/material.dart';

Widget buildAssemblyStep(String step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(step, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }