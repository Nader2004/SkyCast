import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/pages/cities_page.dart';

import 'pages/home_page.dart';

void main() async {
  await dotenv.load(fileName: "weather_api.env");
  runApp(const SkyCast());
}

class SkyCast extends StatelessWidget {
  const SkyCast({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkyCast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 204, 220, 235),
        ),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/cities') {
          final arguments = settings.arguments as Map<String, dynamic>;
          final index = arguments['index'] as int;
          final weatherCities = arguments['weatherCities'] as List<City>;
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, firstAnimation, secondAnimation) =>
                CitiesPage(
              index: index,
              weatherCities: weatherCities,
            ),
            transitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) =>
                ScaleTransition(scale: animation, child: child),
          );
        }
        return null;
      },
    );
  }
}
