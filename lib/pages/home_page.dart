import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    fetchWeatherData();
    _focusNode.addListener(_focusListener);
    super.initState();
  }

  void _focusListener() {
    debugPrint('Focus: ${_focusNode.hasFocus}');
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
                  SliverToBoxAdapter(
                    child: TopBar(
                      onSearch: (value) {},
                      focusNode: _focusNode,
                      isReadyToType: _readyToType,
                    ),
                  ),
                ],
                body: ListView.builder(
                  itemBuilder: (context, index) => const CityWeatherInfo(),
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
