import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/services/database/city_database_service.dart';
import 'package:sky_cast/services/weather_api_service.dart';
import 'package:sky_cast/widgets/city_addition_bottom_sheet.dart';
import 'package:sky_cast/widgets/city_weather_info.dart';
import 'package:sky_cast/widgets/connectivity_widget.dart';
import 'package:sky_cast/widgets/no_internet_widget.dart';
import 'package:sky_cast/widgets/top_bar.dart';

/// The main page of the SkyCast app, displaying weather information for cities.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CityDatabaseService _cityDatabaseService;
  late StreamSubscription<ConnectivityResult> _subscription;
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  final FocusNode _focusNode = FocusNode();
  final List<City> _weatherCities = [];

  bool _readyToType = false;
  bool _openAppSettingsForPermission = false;
  String _searchValue = '';
  List<City> _filteredCities = [];

  @override
  void initState() {
    _initDBAndServices();
    _focusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final connectivityService =
        ConnectivityProvider.of(context)!.connectivityService;
    _subscription = connectivityService.connectivityStream.listen((result) {
      setState(() {
        _connectivityResult = result;
      });
    });
  }

  /// database and loads saved cities.
  Future<void> _initDBAndServices() async {
    _cityDatabaseService = CityDatabaseService.instance;

    // Await the results of Future.wait
    final results = await Future.wait([
      _getCurrentPosition(),
      _cityDatabaseService.readAll(),
    ]);

    final City? currentPositionCity = results[0] as City?;
    final List<City> citiesFromDatabase = results[1] as List<City>;

    if (currentPositionCity != null) {
      setState(() {
        _weatherCities.insert(0, currentPositionCity);
      });
    }

    setState(() {
      _weatherCities.addAll(citiesFromDatabase);
    });
  }

  /// Handles location permission requests.
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
      setState(() => _openAppSettingsForPermission = true);
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
        setState(() => _openAppSettingsForPermission = true);
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
      setState(() => _openAppSettingsForPermission = true);
      return false;
    }
    return true;
  }

  /// Gets the current position of the device and returns a [City] object.
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
      orderIndex: 0,
    );
    return city;
  }

  /// Gets the address from the given latitude and longitude.
  Future<Placemark> _getAddressFromLatLng(Position position) async {
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks.first;
  }

  /// Listener for the focus node to update the UI based on focus state.
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

  /// Highlights occurrences of the search query in the given source string.
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

  Future<void> getCities(String value) async {
    if (value.isEmpty) {
      setState(() {
        _searchValue = '';
        _filteredCities = [];
      });
    } else {
      final List<City> citiesFromApi =
          await WeatherApiService().fetchCity(value);
      Map<String, City> uniqueCityMap = {};

      /// filter out duplicate cities
      for (City city in citiesFromApi) {
        String uniqueKey = "${city.name},${city.country}";
        if (!uniqueCityMap.containsKey(uniqueKey)) {
          uniqueCityMap[uniqueKey] = city;
        }
      }

      final List<City> uniqueCities = uniqueCityMap.values.toList();
      setState(() {
        _searchValue = value;
        _filteredCities = uniqueCities;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    _cityDatabaseService.close();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light
          .copyWith(statusBarColor: Theme.of(context).colorScheme.surface),
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
                      refresh: () => setState(() {}),
                      onSearch: (value) {
                        getCities(value);
                      },
                      focusNode: _focusNode,
                      isReadyToType: _readyToType,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _openAppSettingsForPermission
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: ListTile(
                              leading: const Icon(
                                Icons.location_off_rounded,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Location is off',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: const Text(
                                'Please turn on location services to use this feature',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: TextButton(
                                onPressed: () => Geolocator.openAppSettings(),
                                child: const Text(
                                  'Open',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
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
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                isScrollControlled: true,
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
                                  _weatherCities.removeWhere((element) =>
                                      element.name ==
                                      _filteredCities[index].name);
                                });
                              }
                            }),
                        itemCount: _filteredCities.length,
                      )
                    : ReorderableListView(
                        onReorder: (oldIndex, newIndex) {
                          if (newIndex != 0) {
                            setState(() {
                              if (newIndex > _weatherCities.length) {
                                newIndex = _weatherCities.length;
                              }
                              if (oldIndex < newIndex) newIndex--;

                              City item = _weatherCities[oldIndex];
                              _weatherCities.remove(item);
                              _weatherCities.insert(newIndex, item);
                            });
                            CityDatabaseService.instance
                                .reorderCities(_weatherCities);
                          }
                        },
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        children: _weatherCities
                            .map(
                              (city) => GestureDetector(
                                key: ValueKey(city.name),
                                onLongPress: !city.isMyLocation ? null : () {},
                                child: CityWeatherInfo(
                                  city: city,
                                  weatherCities: _weatherCities,
                                  index: _weatherCities.indexOf(city),
                                  onDelete: () {
                                    setState(() {
                                      _weatherCities.removeAt(
                                          _weatherCities.indexOf(city));
                                      _cityDatabaseService.delete(city.name);
                                    });
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
