/// Returns the URL for the weather icon based on the given icon code.
///
/// The [iconCode] parameter is a string representing the weather icon code
/// provided by the OpenWeatherMap API.
///
/// The function constructs the URL for the weather icon using the given icon code.
///
/// Example:
/// ```dart
/// final iconCode = '10d';
/// final iconUrl = getWeatherIcon(iconCode); // Returns 'http://openweathermap.org/img/w/10d.png'
/// ```
String getWeatherIcon(String iconCode) {
  return 'http://openweathermap.org/img/w/$iconCode.png';
}