import 'package:flutter/material.dart' hide SearchBar;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'search_bar.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 20),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              MdiIcons.dotsHorizontal,
              color: Colors.grey,
              size: 30,
            ),
          ),
          const SearchBar(),
        ],
      ),
    );
  }
}
