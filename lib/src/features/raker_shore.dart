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

  String workingPoint = "**cm";
  String wallPlateLength = "**cm";
  bool is45Degree = true;

  void calculateMeasurements() {
    setState(() {
      double insertionPoint = double.tryParse(insertionPointController.text) ?? 0;
      double cleatLength = is45Degree ? 24 * 2.54 : 30 * 2.54; // Convert inches to cm
      wallPlateLength = "${(insertionPoint + cleatLength).toStringAsFixed(2)} cm";
      
      if (is45Degree) {
          workingPoint = "${sqrt(2 * pow(insertionPoint, 2)).toStringAsFixed(2)} cm";
      } else {
          workingPoint = "${(insertionPoint * 0.0328084 * 14 * 2.54).toStringAsFixed(2)} cm";
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateMeasurements,
              child: const Text("Calculate Measurements"),
            ),
            const SizedBox(height: 16),
            const Text("Final Measurements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildMeasurementRow("Working Point Length", workingPoint),
            buildMeasurementRow("Wall Plate Length", wallPlateLength),
            const SizedBox(height: 16),
            const Text("Requirements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("(4 x 4)"),
            const Text("- Wall Plate\n- Raker\n- Sole Plate"),
            const Text("(2 x 4)"),
            const Text("- Mid-point braces (only if raker is >11ft) x 2\n- 24\" bottom cleat x 1\n- 24\"/30\" top cleat for 45°/60° raker respectively x 1"),
            const Text("- Wedge Set x 2"),
            const Text("(Plywood)"),
            const Text("- Full Gussets(30cmx30cm) x 6"),
            const SizedBox(height: 16),
            const Text("Assembly Guide", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildAssemblyStep("HOW TO CONSTRUCT A SOLID SOLE RAKER"),
            buildAssemblyStep("Step 1: Determine where to erect the raker shores, the height of supported wall, and the height of Insertion Point."),
            buildAssemblyStep("Step 2: If area is not clear of debris, consider Split Sole Raker."),
            buildAssemblyStep("Step 3: Select angle of Raker, then measure and cut the Wall Plate, Sole Plate and Raker to the proper length."),
            buildAssemblyStep("Step 4: Pre-fabricate Wall Plate, Raker, Sole, and Sole Anchor."),
            buildAssemblyStep("Step 5: Carefully move the partially prefabricated Rake Shore in place at the wall and make sure it is plumb."),
            buildAssemblyStep("Step 6: After anchoring Sole Plate, install wedges between the bottom cleat and base of the Raker and tighten them slightly."),
            buildAssemblyStep("Step 7: Prevent the Raker shore from sliding up the wall using anchors."),
            buildAssemblyStep("Step 8: Attach Mid Point Braces if necessary."),
            buildAssemblyStep("Step 9: Attach Horizontal Braces."),
            buildAssemblyStep("Step 10: All raker shore systems must be connected with either X or V bracing."),
            buildAssemblyStep("Step 11: Attach the first brace to the rakers near the top and bottom."),
            buildAssemblyStep("Step 12: Methods to Anchor the Sole Plate to prevent sliding."),
            const SizedBox(height: 16),
            const Text("ADDITIONAL INFORMATION - Solid Sole Raker", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildAssemblyStep("1. Design Load for one Raker: 4x4 Raker = 4,000lb, 6x6 Raker = 5,600lb"),
            buildAssemblyStep("2. Raker information: Maximum length without mid-brace: 4x4 = 11ft, 6x6 = 17ft"),
            buildAssemblyStep("3. To attach wall plate directly to a concrete/masonry wall, use drill-in anchors."),
            buildAssemblyStep("4. To attach the wall plate directly to a wood framed wall, use appropriate backing and nails."),
            buildAssemblyStep("5. Place an 18\" x 18\" Foot under the sole at intersection of raker when bearing on soil."),
            buildAssemblyStep("6. A Sole Anchor can be secured to the ground or floor behind the sole plate to prevent backing away from the wall."),
          ],
        ),
      ),
    );
  }
}
