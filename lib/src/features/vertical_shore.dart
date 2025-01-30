import 'package:flutter/material.dart';

import '../common/measurement_row.dart';
import '../common/numeric_field.dart';

class VerticalShorePage extends StatefulWidget {
  const VerticalShorePage({super.key});
  static const routeName = '/verticalshore';

  @override
  State<VerticalShorePage> createState() => _VerticalShorePageState();
}

class _VerticalShorePageState extends State<VerticalShorePage> {
  final TextEditingController totalHeightController = TextEditingController();
  final TextEditingController headerController = TextEditingController();
  final TextEditingController soleplateController = TextEditingController();
  final TextEditingController wedgeController = TextEditingController();

  String verticalPostMeasurement = "** cm";

  void calculateMeasurements() {
    setState(() {
      double totalHeightValue = double.tryParse(totalHeightController.text) ?? 0;
      double headerValue = double.tryParse(headerController.text) ?? 0;
      double soleplateValue = double.tryParse(soleplateController.text) ?? 0;
      double wedgeValue = double.tryParse(wedgeController.text) ?? 0;

      verticalPostMeasurement = "${totalHeightValue - headerValue - wedgeValue - soleplateValue} cm";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vertical Shore"),
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
                'assets/images/vertical_shore.png',
                height: MediaQuery.of(context).size.height * 0.4, // 40% of screen height
                width: double.infinity,
                fit: BoxFit.contain, // Scales while keeping aspect ratio
              ),
            ),
            const SizedBox(height: 16),
            const Text("Enter Measurements (cm)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildNumericField("Total Height (h)", totalHeightController),
            buildNumericField("Header Length (hh)", headerController),
            buildNumericField("Soleplate Length (hs)", soleplateController),
            buildNumericField("Wedges (w)", wedgeController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateMeasurements,
              child: const Text("Calculate Measurements"),
            ),
            const SizedBox(height: 16),
            const Text("Final Measurements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildMeasurementRow("Vertical Post", verticalPostMeasurement),
            const SizedBox(height: 16),
            const Text("Requirements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("(4 x 4)") ,
            const Text("- Header\n- Soleplate\n-VerticalPost"),
            const Text("(4 x 2)") ,
            const Text("-Wedge Set x 1"),
            const Text("(30 x 15 cm)") ,
            const Text("- Half Gusset x 4"), 
            const SizedBox(height: 16),
            const Text("Assembly Guide", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}