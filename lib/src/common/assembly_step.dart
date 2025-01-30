import 'package:flutter/material.dart';

Widget buildAssemblyStep(String step, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, height: 100, width: double.infinity, fit: BoxFit.cover),
          Text(step, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }