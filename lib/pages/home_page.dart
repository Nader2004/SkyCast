import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_cast/constants/cities.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/widgets/city_addition_bottom_sheet.dart';
import 'package:sky_cast/widgets/city_weather_info.dart';
import 'package:sky_cast/widgets/top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences _prefs;

  final FocusNode _focusNode = FocusNode();
  final List<City> _weatherCities = [];

  bool _readyToType = false;
  String _searchValue = '';
  List<City> _filteredCities = [];

  @override
  void initState() {
    _initPrefs();
    _focusNode.addListener(_focusListener);
    super.initState();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('cities')) {
      Map<String, City> cityMap = {for (City city in cities) city.name: city};
      for (String cityName in _prefs.getStringList('cities')!) {
        City? city = cityMap[cityName];
        if (city != null) {
          _weatherCities.add(city);
        }
      }
    }
    final City? city = await _getCurrentPosition();
    if (city != null) {
      setState(() {
        _weatherCities.insert(0, city);
      });
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.'),
        ),
      );
      return false;
    }
    return true;
  }

  Future<City?> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return null;
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final Placemark placemark = await _getAddressFromLatLng(position);
    final City city = City(
      name: placemark.locality!,
      country: placemark.country!,
      lon: position.longitude,
      lat: position.latitude,
      isMyLocation: true,
    );
    return city;
  }

  Future<Placemark> _getAddressFromLatLng(Position position) async {
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks.first;
  }

  void _focusListener() {
    if (_focusNode.hasFocus) {
      setState(() {
        _readyToType = true;
      });
    } else {
      setState(() {
        _readyToType = false;
      });
    }
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty) {
      return [TextSpan(text: source)];
    }

    List<TextSpan> spans = <TextSpan>[];
    int start = 0;
    int indexOfHighlight = source.toLowerCase().indexOf(query.toLowerCase());

    while (indexOfHighlight != -1) {
      spans.add(TextSpan(text: source.substring(start, indexOfHighlight)));
      start = indexOfHighlight;
      indexOfHighlight = start + query.length;
      spans.add(TextSpan(
        text: source.substring(start, indexOfHighlight),
        style: const TextStyle(color: Colors.blue),
      ));
      start = indexOfHighlight;
      indexOfHighlight =
          source.toLowerCase().indexOf(query.toLowerCase(), start);
    }

    spans.add(TextSpan(text: source.substring(start)));

    return spans;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light
          .copyWith(statusBarColor: Theme.of(context).colorScheme.background),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              body: NestedScrollView(
                headerSliverBuilder: (context, _) => [
                  SliverAppBar(
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(
                        _readyToType
                            ? MediaQuery.of(context).size.height * 0.04
                            : MediaQuery.of(context).size.height * 0.09,
                      ),
                      child: const SizedBox.shrink(),
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    floating: true,
                    snap: true,
                    flexibleSpace: TopBar(
                      onSearch: (value) {
                        setState(() {
                          _searchValue = value;
                          if (_searchValue.isEmpty) {
                            _filteredCities = cities;
                          } else {
                            List<City> startsWith = cities
                                .where((city) =>
                                    city.name.toLowerCase().startsWith(
                                        _searchValue.toLowerCase()) ||
                                    ('${city.name}, ${city.country}')
                                        .toLowerCase()
                                        .startsWith(_searchValue.toLowerCase()))
                                .toList();
                            List<City> contains = cities
                                .where((city) =>
                                    city.name
                                        .toLowerCase()
                                        .contains(_searchValue.toLowerCase()) ||
                                    ('${city.name}, ${city.country}')
                                        .toLowerCase()
                                        .contains(_searchValue.toLowerCase()))
                                .toList();
                            _filteredCities = startsWith +
                                contains
                                    .where((city) => !startsWith.contains(city))
                                    .toList();
                          }
                        });
                      },
                      focusNode: _focusNode,
                      isReadyToType: _readyToType,
                    ),
                  ),
                ],
                body: _searchValue.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                            leading: const Icon(Icons.location_city),
                            title: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: highlightOccurrences(
                                  '${_filteredCities[index].name}, ${_filteredCities[index].country}',
                                  _searchValue,
                                ),
                              ),
                            ),
                            onTap: () async {
                              final map = await showModalBottomSheet<
                                  Map<String, dynamic>?>(
                                context: context,
                                builder: (context) {
                                  return CityAdditionButtomSheet(
                                    city: _filteredCities[index],
                                    action: () =>
                                        setState(() => _searchValue = ''),
                                  );
                                },
                              );
                              if (map == null) return;
                              if (map['action'] == 'add') {
                                setState(() {
                                  _weatherCities.add(_filteredCities[index]);
                                });
                              } else {
                                setState(() {
                                  _weatherCities.remove(_filteredCities[index]);
                                });
                              }
                            }),
                        itemCount: _filteredCities.length,
                      )
                    : ReorderableListView.builder(
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            // These two lines are workarounds for ReorderableListView problems
                            if (newIndex > _weatherCities.length) {
                              newIndex = _weatherCities.length;
                            }
                            if (oldIndex < newIndex) newIndex--;

                            City item = _weatherCities[oldIndex];
                            _weatherCities.remove(item);
                            _weatherCities.insert(newIndex, item);
                            _prefs.setStringList(
                              'cities',
                              _weatherCities.map((e) => e.name).toList(),
                            );
                          });
                        },
                        itemBuilder: (context, index) => CityWeatherInfo(
                          key: ValueKey(index),
                          city: _weatherCities[index],
                        ),
                        itemCount: _weatherCities.length,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
