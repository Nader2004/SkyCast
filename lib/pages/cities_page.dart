import 'package:flutter/material.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/widgets/city_weather_page_info.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// A page that displays weather information for multiple cities using a page view.
class CitiesPage extends StatefulWidget {
  /// The initial index of the page view.
  final int index;

  /// The list of cities for which weather information is displayed.
  final List<City> weatherCities;

  /// Creates a [CitiesPage] widget.
  const CitiesPage({
    super.key,
    required this.index,
    required this.weatherCities,
  });

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage>
    with AutomaticKeepAliveClientMixin {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              final city = widget.weatherCities[index];
              return CityWeatherInfoPage(city: city);
            },
            itemCount: widget.weatherCities.length,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.08,
                color: Colors.grey[600]!.withOpacity(0.3),
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(flex: 2),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: widget.weatherCities.length,
                      effect: const ScrollingDotsEffect(
                        activeDotColor: Colors.white,
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                      onDotClicked: (index) => _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeIn,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
