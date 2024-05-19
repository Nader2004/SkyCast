import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: TextField(
        style: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.w400,
        ),
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
