import 'package:flutter/material.dart';

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
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text("Enter Measurements (cm)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField("Left[h]", leftController),
            _buildTextField("Right[h]", rightController),
            _buildTextField("Header[l]", headerController),
            _buildTextField("Soleplate[l]", soleplateController),
            _buildTextField("Header[hh]", headerHeightController),
            _buildTextField("Soleplate[hs]", soleplateThicknessController),
            _buildTextField("Wedges[w]", wedgesController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateMeasurements,
              child: const Text("Calculate Measurements"),
            ),
            const SizedBox(height: 16),
            const Text("Final Measurements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildMeasurementRow("Header", headerMeasurement),
            _buildMeasurementRow("Soleplate", soleplateMeasurement),
            _buildMeasurementRow("Left Vertical", leftVerticalMeasurement),
            _buildMeasurementRow("Right Vertical", rightVerticalMeasurement),
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
            _buildAssemblyStep("Step 1: Set up the base framework using the 4\" by 4\" cleats", 'assets/images/assembly_step_1.jpg'),
            _buildAssemblyStep("Step 2: Align the horizontal supports and secure with brackets.", 'assets/images/assembly_step_2.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildMeasurementRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAssemblyStep(String step, String imagePath) {
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
}
