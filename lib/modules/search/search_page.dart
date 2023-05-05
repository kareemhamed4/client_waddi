import 'package:flutter/material.dart';
import 'package:waddy_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Track Code',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            defaultTextForm(
              controller: searchController,
              type: TextInputType.text,
              text: 'track code',
              prefix: Icons.search,
              valid: (String? value) {
                if (value!.isEmpty) {
                  return 'search must not be empty';
                }
                return null;
              },
              onChange: (String value) {},
            ),
          ],
        ),
      ),
    );
  }
}
