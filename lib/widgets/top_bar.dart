import 'package:flutter/material.dart' hide SearchBar;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'search_bar.dart';

class TopBar extends StatefulWidget {
  final Function(String) onSearch;
  final FocusNode focusNode;
  final bool isReadyToType;
  const TopBar(
      {super.key,
      required this.onSearch,
      required this.focusNode,
      required this.isReadyToType});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final TextEditingController _controller = TextEditingController();
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 20),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          widget.isReadyToType
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: () {},
                  icon: Icon(
                    MdiIcons.dotsHorizontal,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
          Row(
            children: [
              Expanded(
                child: SearchBar(
                  controller: _controller,
                  onSearch: (value) {
                    widget.onSearch(value);
                    setState(() => searchValue = value);
                  },
                  focusNode: widget.focusNode,
                ),
              ),
              widget.isReadyToType
                  ? TextButton(
                      onPressed: () {
                        widget.focusNode.unfocus();
                        widget.onSearch('');
                        searchValue = '';
                        _controller.clear();
                      },
                      child: const Text('Cancel'),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
