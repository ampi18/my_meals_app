import 'package:flutter/material.dart';

class FilterRatingButton extends StatefulWidget {
  const FilterRatingButton({super.key, required this.onSelectionChanged});
  final Function onSelectionChanged;

  @override
  State<FilterRatingButton> createState() => _FilterRatingButtonState();
}

class _FilterRatingButtonState extends State<FilterRatingButton> {
  List<bool> selectedRatings = List<bool>.filled(5, true);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff79747e)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: PopupMenuButton<int>(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.filter_alt,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text('Rating',
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ],
        ),
        itemBuilder: (context) =>
            List<PopupMenuEntry<int>>.generate(5, (index) {
          return PopupMenuItem<int>(
            value: index + 1,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return CheckboxListTile(
                  value: selectedRatings[index],
                  onChanged: (bool? value) {
                    if (value == false &&
                        selectedRatings.where((element) => element).length ==
                            1) {
                      // Prevent unchecking the last checked checkbox
                      return;
                    }
                    setState(() {
                      selectedRatings[index] = value!;
                      widget.onSelectionChanged(selectedRatings
                          .asMap()
                          .entries
                          .where((entry) => entry.value)
                          .map((entry) => entry.key + 1)
                          .toList());
                    });
                  },
                  title: Row(
                    children: List<Widget>.generate(
                      index + 1,
                      (starIndex) => const Icon(Icons.star),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
