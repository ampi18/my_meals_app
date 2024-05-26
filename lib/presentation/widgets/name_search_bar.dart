import 'package:flutter/material.dart';

class NameSearchBar extends StatelessWidget {
  final List<String> suggestions = [
    "USA",
    "UK",
    "Uganda",
    "Uruguay",
    "United Arab Emirates"
  ];
  NameSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        } else {
          List<String> matches = <String>[];
          matches.addAll(suggestions);
          matches.retainWhere((s) =>
              s.toLowerCase().contains(textEditingValue.text.toLowerCase()));
          return matches;
        }
      },
      onSelected: (String selection) {},
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Country',
            hintText: 'Start typing...',
          ),
          controller: textEditingController,
          focusNode: focusNode,
        );
      },
      optionsViewBuilder: (BuildContext context,
          void Function(String) onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: options.map((String option) {
                return GestureDetector(
                  onTap: () {
                    onSelected(option);
                  },
                  child: ListTile(
                    title: Text(option),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
