import 'package:flutter/material.dart';

import '../common/assembly_step.dart';
import '../common/measurement_row.dart';
import '../common/numeric_field.dart';

class WindowShorePage extends StatefulWidget {
  const WindowShorePage({super.key});
  static const routeName = '/windowshore';

  @override
  State<WindowShorePage> createState() => _WindowShorePageState();
}

class _WindowShorePageState extends State<WindowShorePage> {
  final TextEditingController leftController = TextEditingController();
  final TextEditingController rightController = TextEditingController();
  final TextEditingController headerController = TextEditingController();
  final TextEditingController soleplateController = TextEditingController();
  final TextEditingController headerHeightController = TextEditingController();
  final TextEditingController soleplateThicknessController = TextEditingController();
  final TextEditingController wedgesController = TextEditingController();

  String headerMeasurement = "**cm";
  String soleplateMeasurement = "**cm";
  String leftVerticalMeasurement = "**cm";
  String rightVerticalMeasurement = "**cm";

  void calculateMeasurements() {
    setState(() {
      double headerValue = double.tryParse(headerController.text) ?? 0;
      double soleplateValue = double.tryParse(soleplateController.text) ?? 0;
      double leftValue = double.tryParse(leftController.text) ?? 0;
      double rightValue = double.tryParse(rightController.text) ?? 0;
      double wedgesValue = double.tryParse(wedgesController.text) ?? 0;
      double soleplateThicknessValue = double.tryParse(soleplateThicknessController.text) ?? 0;
      double headerHeightValue = double.tryParse(headerHeightController.text) ?? 0;

      headerMeasurement = "${headerValue - wedgesValue} cm";
      soleplateMeasurement = "${soleplateValue - wedgesValue} cm";
      leftVerticalMeasurement = "${leftValue - wedgesValue - soleplateThicknessValue - headerHeightValue} cm";
      rightVerticalMeasurement = "${rightValue - wedgesValue - soleplateThicknessValue - headerHeightValue} cm";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Window Shore"),
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
                'assets/images/window.jpg',
                height: MediaQuery.of(context).size.height * 0.4, // 40% of screen height
                width: double.infinity,
                fit: BoxFit.contain, // Scales while keeping aspect ratio
              ),
            ),
            const SizedBox(height: 16),
            const Text("Enter Measurements (cm)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildNumericField("Left[h]", leftController),
            buildNumericField("Right[h]", rightController),
            buildNumericField("Header[l]", headerController),
            buildNumericField("Soleplate[l]", soleplateController),
            buildNumericField("Header[hh]", headerHeightController),
            buildNumericField("Soleplate[hs]", soleplateThicknessController),
            buildNumericField("Wedges[w]", wedgesController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateMeasurements,
              child: const Text("Calculate Measurements"),
            ),
            const SizedBox(height: 16),
            const Text("Final Measurements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildMeasurementRow("Header", headerMeasurement),
            buildMeasurementRow("Soleplate", soleplateMeasurement),
            buildMeasurementRow("Left Vertical", leftVerticalMeasurement),
            buildMeasurementRow("Right Vertical", rightVerticalMeasurement),
            const SizedBox(height: 16),
            const Text("Requirements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("(4 x 4)") ,
            const Text("- Header\n- Soleplate\n- Left Vertical\n- Right Vertical"),
            const Text("(4 x 2)") ,
            const Text("- Cleat (30cm) x 3\n- Wedge Set x 4"),
            const Text("(30 x 15 cm)") ,
            const Text("- Half Gusset x 1"),
            const SizedBox(height: 16),
            const Text("Assembly Guide", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildAssemblyStep("Step 1: Use 4 x (4\" x 4\") to erect 2 x vertical posts and 2 x horizontal beams"),
            buildAssemblyStep("Step 2: Wedge the 3 x corners using 4 x (4\" x 2\" x 12\")"),
            buildAssemblyStep("Step 3: Attach 4 x (4\" x 2\") cleats and nail them in place")
          ],
        ),
      ),
    );
  }
}
