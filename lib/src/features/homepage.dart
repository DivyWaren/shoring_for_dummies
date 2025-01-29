import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'wood_cut_details_view.dart';
import 'window_shore.dart';
import '../data/data.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // The SingleChildScrolLView makes its child scrollable when
      // the content is too large to fit in the available screen space.
      body: SingleChildScrollView(
        // The Column is a layout widget that arranges its children vertically.
        child: Column(
          // This aligns all children in a column from left to right.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Section for items categorized as shoring types
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Shoring Types',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildGrid(shoringTypes),

            // Section for items categorized as wood cuts
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Wood Cuts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildGrid(woodCuts),

          ],
        ),
      ),
    );
  }

  /// Builds a grid of items based on the provided data.
  Widget _buildGrid(List<Map<String, String>> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(

        // This ensures that the grid view takes only as much space as
        // its children need, rather than taking up all available space.
        shrinkWrap: true,

        // Disables scrolling within the grid itself. This is usually used
        // when the grid is inside a scrollable container when you don't want
        // the grid to scroll independently.
        physics: const NeverScrollableScrollPhysics(),

        // Defines the grid layout
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          mainAxisSpacing: 16, // Space between rows i.e. vertical spacing
          crossAxisSpacing: 16, // Space between columns i.e. horizontal spacing
          childAspectRatio: 1 / 1, // Adjust this to control the card's size
        ),

        itemCount: items.length,

        // This function is called for each item and can be used to get the current item.
        itemBuilder: (context, index) {
          final item = items[index];

          // Wraps the grid item to detect taps which triggers the onTap function.
          return GestureDetector(
            onTap: () {
              // Checks if the tapped item is a wood cut
              if (woodCuts.contains(item)) {
                // Navigate to the details page for wood cuts
                Navigator.restorablePushNamed(
                  context,
                  WoodCutDetailsView.routeName,
                  arguments: item, // Pass the item as an argument
                );
              } 
              // Checks if the tapped item is Window Shore
              else if (item['title'] == 'Window Shore') {
                Navigator.restorablePushNamed(
                  context,
                  WindowShorePage.routeName,
                  arguments: item, // Pass the item as an argument
                );
              }
              else {
                // Show a notification if tapped item is a shoring type
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${item['title']} is a Shoring Type.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1, // Make the image square
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0), // Clips the image to have rounded corners with a radius of 8px
                      child: Image.asset(
                        item['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['title']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}