import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatefulWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  // Creates a mutable state for the widget
  @override
  State<SampleItemDetailsView> createState() => _SampleItemDetailsViewState();
}

// The state class for the SampleItemDetailsView widget
class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
  // To keep track of the selected button (0: Description, 1: Usage)
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Retrieves item data through the navigation route
    final item = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final hasUsage = item.containsKey('usage') && item['usage'] != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(item['title'] ?? 'Item Details'),
      ),
      body: SingleChildScrollView( // Widget to allow its child widget to be scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  item['image']!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Full-width buttons
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    // Description Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: selectedIndex == 0 ? Colors.blue : Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            border: Border.all(color: Colors.black),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Usage Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (hasUsage) {
                            setState(() {
                              selectedIndex = 1;
                            });
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: selectedIndex == 1 ? Colors.blue : Colors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            border: Border.all(color: Colors.black),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Usage',
                            style: TextStyle(
                              color: hasUsage ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Display content based on the selected index
              if (selectedIndex == 0)
                Text(
                  item['description'] ?? 'No description available.',
                  style: const TextStyle(fontSize: 16),
                )
              else
                Text(
                  item['usage'] ?? 'No usage details available.',
                  style: const TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
