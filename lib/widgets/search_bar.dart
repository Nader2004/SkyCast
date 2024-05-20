import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSearch;
  final FocusNode focusNode;
  final TextEditingController controller;
  const SearchBar(
      {super.key,
      required this.onSearch,
      required this.focusNode,
      required this.controller});

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
