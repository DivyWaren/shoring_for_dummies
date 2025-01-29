import 'package:flutter/material.dart';

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
            _buildTextField("Total Height (h)", totalHeightController),
            _buildTextField("Header Length (hh)", headerController),
            _buildTextField("Soleplate Length (hs)", soleplateController),
            _buildTextField("Wedges (w)", wedgeController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateMeasurements,
              child: const Text("Calculate Measurements"),
            ),
            const SizedBox(height: 16),
            const Text("Final Measurements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildMeasurementRow("Vertical Post", verticalPostMeasurement),
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