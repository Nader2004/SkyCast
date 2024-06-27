import 'package:flutter/material.dart';

/// A custom search bar widget for searching cities.
class SearchBar extends StatelessWidget {
  /// Callback function when the search input changes.
  final Function(String) onSearch;

  /// Focus node for managing focus state of the search bar.
  final FocusNode focusNode;

  /// Controller for managing the text input of the search bar.
  final TextEditingController controller;

  /// Creates a [SearchBar] widget.
  const SearchBar({
    super.key,
    required this.onSearch,
    required this.focusNode,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: TextField(
        style: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.w400,
        ),
        controller: controller,
        focusNode: focusNode,
        onChanged: onSearch,
        cursorColor: Colors.grey[600],
        cursorHeight: 22,
        decoration: InputDecoration(
          hintText: 'Search for a city',
          hintStyle: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[700],
          ),
          suffixIcon: focusNode.hasFocus
              ? IconButton(
                  onPressed: () {
                    onSearch('');
                    controller.clear();
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: Colors.grey[700],
                  ),
                )
              : null,
          filled: true,
          fillColor: Colors.grey.withOpacity(0.3),
          contentPadding: const EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}