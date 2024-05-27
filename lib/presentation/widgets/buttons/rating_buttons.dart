import 'package:flutter/material.dart';

class RatingButtons extends StatefulWidget {
  final int? initalRating;
  final Function(int) onRatingChanged;
  final bool readOnly;

  const RatingButtons(
      {super.key,
      this.initalRating,
      required this.onRatingChanged,
      this.readOnly = false});

  @override
  State<RatingButtons> createState() => _RatingButtonsState();
}

class _RatingButtonsState extends State<RatingButtons> {
  late List<bool> isFilled;

  @override
  void initState() {
    super.initState();
    isFilled = widget.initalRating != null
        ? List.generate(5, (index) => index < widget.initalRating!)
        : List.from([true, false, false, false, false]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            isFilled[index] ? Icons.star : Icons.star_border,
            color: Colors.yellow,
          ),
          onPressed: () {
            if (!widget.readOnly) {
              onIconPressed(index);
            }
          },
        );
      }),
    );
  }

  void onIconPressed(int index) {
    setState(() {
      for (int i = 0; i <= index; i++) {
        isFilled[i] = true;
      }
      for (int i = index + 1; i < 5; i++) {
        isFilled[i] = false;
      }
    });
    widget.onRatingChanged(index + 1);
  }
}
