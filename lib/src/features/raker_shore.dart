import 'package:flutter/material.dart';
import 'dart:math';

import '../common/assembly_step.dart';
import '../common/measurement_row.dart';
import '../common/numeric_field.dart';

class RakerShorePage extends StatefulWidget {
  const RakerShorePage({super.key});
  static const routeName = '/rakershore';

  @override
  State<RakerShorePage> createState() => _RakerShorePageState();
}

class _RakerShorePageState extends State<RakerShorePage> {
  final TextEditingController insertionPointController = TextEditingController();
  final TextEditingController wallCleatController = TextEditingController();
  final TextEditingController soleplateCleatController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String workingPoint = "**cm";
  bool is45Degree = true;

  void calculateWorkingPoint() {
    setState(() {
      double insertionPoint = double.tryParse(insertionPointController.text) ?? 0;
      double height = double.tryParse(heightController.text) ?? 0;

      if (is45Degree) {
        workingPoint = "${sqrt(2 * pow(insertionPoint, 2)).toStringAsFixed(2)} cm";
      } else {
        workingPoint = "${sqrt(pow(insertionPoint, 2) + pow(height, 2)).toStringAsFixed(2)} cm";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Raker Shore"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                is45Degree ? 'assets/images/45_raker.jpg' : 'assets/images/60_raker.jpg',
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            const Text("Select Raker Type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: const Text("45° Raker"),
                    value: true,
                    groupValue: is45Degree,
                    onChanged: (bool? value) {
                      setState(() {
                        is45Degree = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text("60° Raker"),
                    value: false,
                    groupValue: is45Degree,
                    onChanged: (bool? value) {
                      setState(() {
                        is45Degree = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            buildNumericField("Insertion Point Length", insertionPointController),
            if (!is45Degree) buildNumericField("Height", heightController),
            buildNumericField("Wall Cleat Length", wallCleatController),
            buildNumericField("Soleplate Cleat Length", soleplateCleatController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateWorkingPoint,
              child: const Text("Calculate Working Point"),
            ),
            const SizedBox(height: 16),
            const Text("Final Measurements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildMeasurementRow("Working Point Length", workingPoint),
            const SizedBox(height: 16),
            const Text("Assembly Guide", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildAssemblyStep("Step 1: Set up the wall plate and soleplate.", 'assets/images/assembly_step_1.jpg'),
            buildAssemblyStep("Step 2: Position the raker and secure using cleats.", 'assets/images/assembly_step_2.jpg'),
          ],
        ),
      ),
    );
  }
}
