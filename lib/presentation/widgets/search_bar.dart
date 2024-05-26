import 'package:flutter/material.dart';

class ListSearchBar extends StatefulWidget {
  final Function onInputChanged;
  const ListSearchBar({super.key, required this.onInputChanged});

  @override
  State<ListSearchBar> createState() => _ListSearchBarState();
}

class _ListSearchBarState extends State<ListSearchBar> {
  final TextEditingController _textEditingController = TextEditingController();

  String get _searchText => _textEditingController.text;

  void _clearTextField() {
    _textEditingController.clear();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: _textEditingController,
          onChanged: (_) => widget.onInputChanged(_searchText),
          decoration: InputDecoration(
            labelText: 'Search by name',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        if (_textEditingController.text.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _clearTextField,
            ),
          ),
      ],
    );
  }
}
