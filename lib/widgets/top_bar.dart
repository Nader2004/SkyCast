import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'search_bar.dart';

/// A top bar widget that includes a search bar and settings options.
class TopBar extends StatefulWidget {
  /// Callback to refresh the parent widget.
  final VoidCallback refresh;

  /// Callback for search input.
  final Function(String) onSearch;

  /// Focus node for the search bar.
  final FocusNode focusNode;

  /// Indicates whether the search bar is ready to accept input.
  final bool isReadyToType;

  /// Creates a [TopBar] widget.
  const TopBar({
    super.key,
    required this.refresh,
    required this.onSearch,
    required this.focusNode,
    required this.isReadyToType,
  });

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late SharedPreferences _prefs;
  final TextEditingController _controller = TextEditingController();
  String searchValue = '';
  String _selectedTemperatureUnit = 'Celsius';
  String _selectedWindSpeedUnit = 'km/h';
  String _selectedPressureUnit = 'hPa';

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  /// Initialize the shared preferences.
  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTemperatureUnit =
          _prefs.getString('temperatureUnit') ?? 'Celsius';
    });
  }

  /// Builds a single unit selection tile.
  Widget _buildSingleUnitTile({
    required String title,
    required String option1,
    required String option2,
    required Function() onTap1,
    required Function() onTap2,
    required bool expression1,
    required bool expression2,
  }) {
    return ExpansionTile(
      title: Text(title),
      children: [
        ListTile(
          title: Text(option1),
          onTap: () {
            widget.refresh();
            onTap1();
            Future.delayed(const Duration(milliseconds: 200), () {
              Navigator.pop(context);
            });
          },
          trailing: expression1
              ? null
              : const Icon(CupertinoIcons.check_mark_circled),
        ),
        ListTile(
          title: Text(option2),
          onTap: () {
            widget.refresh();
            onTap2();
            Future.delayed(const Duration(milliseconds: 200), () {
              Navigator.pop(context);
            });
          },
          trailing: expression2
              ? null
              : const Icon(CupertinoIcons.check_mark_circled),
        ),
      ],
    );
  }

  /// Opens a bottom sheet for unit selection.
  void openUnitsBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSingleUnitTile(
                      title: 'Temperature Unit',
                      option1: 'Celsius',
                      option2: 'Fahrenheit',
                      onTap1: () {
                        _prefs.setString('temperatureUnit', 'Celsius');
                        setModalState(
                            () => _selectedTemperatureUnit = 'Celsius');
                      },
                      onTap2: () {
                        _prefs.setString('temperatureUnit', 'Fahrenheit');
                        setModalState(
                            () => _selectedTemperatureUnit = 'Fahrenheit');
                      },
                      expression1: _selectedTemperatureUnit != 'Celsius',
                      expression2: _selectedTemperatureUnit != 'Fahrenheit',
                    ),
                    _buildSingleUnitTile(
                      title: 'Wind Speed Unit',
                      option1: 'm/s',
                      option2: 'km/h',
                      onTap1: () {
                        _prefs.setString('windSpeedUnit', 'm/s');
                        setModalState(() => _selectedWindSpeedUnit = 'm/s');
                      },
                      onTap2: () {
                        _prefs.setString('windSpeedUnit', 'km/h');
                        setModalState(() => _selectedWindSpeedUnit = 'km/h');
                      },
                      expression1: _selectedWindSpeedUnit != 'm/s',
                      expression2: _selectedWindSpeedUnit != 'km/h',
                    ),
                    _buildSingleUnitTile(
                      title: 'Pressure Unit',
                      option1: 'hPa',
                      option2: 'mmHg',
                      onTap1: () {
                        _prefs.setString('pressureUnit', 'hPa');
                        setModalState(() => _selectedPressureUnit = 'hPa');
                      },
                      onTap2: () {
                        _prefs.setString('pressureUnit', 'mmHg');
                        setModalState(() => _selectedPressureUnit = 'mmHg');
                      },
                      expression1: _selectedPressureUnit != 'hPa',
                      expression2: _selectedPressureUnit != 'mmHg',
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

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
              : PullDownButton(
                  itemBuilder: (context) => [
                    PullDownMenuItem(
                      title: 'Celsius',
                      onTap: () {
                        widget.refresh();
                        _prefs.setString('temperatureUnit', 'Celsius');
                        setState(() => _selectedTemperatureUnit = 'Celsius');
                      },
                      icon: _selectedTemperatureUnit != 'Celsius'
                          ? null
                          : CupertinoIcons.check_mark_circled,
                    ),
                    PullDownMenuItem(
                      title: 'Fahrenheit',
                      onTap: () {
                        widget.refresh();
                        _prefs.setString('temperatureUnit', 'Fahrenheit');
                        setState(() => _selectedTemperatureUnit = 'Fahrenheit');
                      },
                      icon: _selectedTemperatureUnit != 'Fahrenheit'
                          ? null
                          : CupertinoIcons.check_mark_circled,
                    ),
                    const PullDownMenuDivider.large(),
                    PullDownMenuItem(
                      title: 'Units',
                      onTap: () => openUnitsBottomSheet(),
                    ),
                  ],
                  position: PullDownMenuPosition.automatic,
                  buttonBuilder: (context, open) => IconButton(
                    onPressed: open,
                    icon: Icon(
                      MdiIcons.dotsHorizontal,
                      color: Colors.grey,
                      size: 30,
                    ),
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
