import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky_cast/constants/cities.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/services/weather_api_service.dart';
import 'package:sky_cast/widgets/city_weather_info.dart';
import 'package:sky_cast/widgets/top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();

  bool _readyToType = false;
  String _searchValue = '';
  List<City> _filteredCities = [];

  @override
  void initState() {
    fetchWeatherData();
    _focusNode.addListener(_focusListener);
    super.initState();
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

  void fetchWeatherData() async {
    await WeatherApiService().fetchWeather(30.44, -94.04);
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
                          onTap: () {},
                        ),
                        itemCount: _filteredCities.length,
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) =>
                            const CityWeatherInfo(),
                        itemCount: 10,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
