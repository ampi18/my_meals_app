import 'package:flutter/material.dart';

class RatingButtons extends StatefulWidget {
  const RatingButtons({Key? key}) : super(key: key);

  @override
  State<RatingButtons> createState() => _RatingButtonsState();
}

class _RatingButtonsState extends State<RatingButtons> {
  List<bool> isFilled = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            isFilled[index] ? Icons.star : Icons.star_border,
            color: Colors.yellow, // Customize the color as needed
          ),
          onPressed: () {
            onIconPressed(index);
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
  }
}
