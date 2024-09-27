import 'package:farmer_project/screens/sensor_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String apiKey = '543e7fecb08ba2e050f7c1294ab7cfee'; // Replace with your API key
  final double latitude = 60.4720; // Example latitude (Norway)
  final double longitude = 8.4689; // Example longitude (Norway)

  String currentTemperature = '';
  String weatherCondition = '';
  String humidity = '';
  String weatherIcon = '';
  String regionName = '';
  List<dynamic> forecast = [];

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    final String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    final String forecastUrl =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    try {
      final weatherResponse = await http.get(Uri.parse(apiUrl));
      final forecastResponse = await http.get(Uri.parse(forecastUrl));

      if (weatherResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
        final weatherData = json.decode(weatherResponse.body);
        final forecastData = json.decode(forecastResponse.body);

        setState(() {
          currentTemperature = '${weatherData['main']['temp']}°C';
          weatherCondition = weatherData['weather'][0]['description'];
          weatherIcon = weatherData['weather'][0]['icon'];
          humidity = '${weatherData['main']['humidity']}%';
          regionName = weatherData['name']; // Get the region name
          forecast = forecastData['list'];
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 600;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 30),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text(
          'AGRIFARMA',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment, color: Colors.white, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SensorDataScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
             DrawerHeader(
              child: Text(
                'Options',
                style: TextStyle(
                  color: Colors.green[800],
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            _buildDrawerItem(
              icon: Icons.language,
              text: 'Language Selection',
              onTap: () {
                Navigator.pushNamed(context, '/language');
              },
            ),
            _buildDrawerItem(
              icon: Icons.feedback,
              text: 'Feedback',
              onTap: () {
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            _buildDrawerItem(
              icon: Icons.info,
              text: 'About Us',
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            _buildDrawerItem(
              icon: Icons.help,
              text: 'Help',
              onTap: () {
                Navigator.pushNamed(context, '/help');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isWideScreen ? 32.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWeatherSection(isWideScreen),
            const SizedBox(height: 20),
            _buildForecastSection(),
            const SizedBox(height: 20),
            _buildFertilizerRecommendationSection(),
          ],
        ),
      ),
    );
  }

  // Weather Section
  Widget _buildWeatherSection(bool isWideScreen) {
    // Map weather conditions to icons
    IconData weatherIconData;
    switch (weatherCondition.toLowerCase()) {
      case 'clear sky':
        weatherIconData = Icons.wb_sunny; // Sunny
        break;
      case 'few clouds':
      case 'scattered clouds':
        weatherIconData = Icons.cloud; // Cloudy
        break;
      case 'broken clouds':
      case 'overcast clouds':
        weatherIconData = Icons.cloud; // Overcast Clouds
        break;
      case 'shower rain':
      case 'rain':
        weatherIconData = Icons.beach_access; // Rain
        break;
      case 'thunderstorm':
        weatherIconData = Icons.flash_on; // Thunderstorm
        break;
      case 'snow':
        weatherIconData = Icons.ac_unit; // Snow
        break;
      case 'mist':
        weatherIconData = Icons.filter_drama; // Mist
        break;
      default:
        weatherIconData = Icons.help_outline; // Default icon for unknown conditions
        break;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(isWideScreen ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Current Weather',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Icon(
              weatherIconData,
              size: isWideScreen ? 120 : 100,
              color: Colors.blue, // Customize the icon color
            ),
            const SizedBox(height: 10),
            Text(
              'Temperature: $currentTemperature',
              style: TextStyle(fontSize: isWideScreen ? 20 : 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Text(
              'Condition: $weatherCondition',
              style: TextStyle(fontSize: isWideScreen ? 20 : 16),
              textAlign: TextAlign.center,
            ),
            Text(
              'Humidity: $humidity',
              style: TextStyle(fontSize: isWideScreen ? 20 : 16),
              textAlign: TextAlign.center,
            ),
            Text(
              'Region: $regionName',
              style: TextStyle(fontSize: isWideScreen ? 20 : 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }


  // Forecast Section
  Widget _buildForecastSection() {
    // Map weather conditions to icons
    IconData getWeatherIcon(String condition) {
      switch (condition.toLowerCase()) {
        case 'clear sky':
          return Icons.wb_sunny; // Sunny
        case 'few clouds':
        case 'scattered clouds':
          return Icons.cloud; // Few Clouds
        case 'broken clouds':
        case 'overcast clouds':
          return Icons.cloud; // Broken Clouds
        case 'shower rain':
        case 'rain':
          return Icons.beach_access; // Rain
        case 'thunderstorm':
          return Icons.flash_on; // Thunderstorm
        case 'snow':
          return Icons.ac_unit; // Snow
        case 'mist':
          return Icons.filter_drama; // Mist
        case 'haze':
          return Icons.wb_cloudy; // Haze
        case 'dust':
          return Icons.wb_cloudy; // Dust (represented as cloudy)
        case 'fog':
          return Icons.filter_drama; // Fog
        case 'sleet':
          return Icons.ac_unit; // Sleet (represented as snow)
        default:
          return Icons.help_outline; // Default icon for unknown conditions
      }
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming Weather Forecast',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecast.length,
                itemBuilder: (context, index) {
                  final item = forecast[index];
                  final temp = item['main']['temp'];
                  final condition = item['weather'][0]['description'];
                  final time = item['dt_txt'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Icon(
                          getWeatherIcon(condition),
                          size: 50,
                          color: Colors.blue, // Customize the icon color
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${temp.toString()}°C',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          time.split(' ')[1].substring(0, 5), // Displaying only the time
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildFertilizerRecommendationSection() {
    // Example recommendations based on temperature and humidity
    String cropRecommendation;
    if (currentTemperature.isNotEmpty && humidity.isNotEmpty) {
      double temperature = double.tryParse(currentTemperature.replaceAll('°C', '')) ?? 0;
      double humidityValue = double.tryParse(humidity.replaceAll('%', '')) ?? 0;

      if (temperature > 25 && humidityValue > 60) {
        cropRecommendation = 'Recommended Crops: Tomatoes, Peppers, Cucumbers';
      } else if (temperature > 15 && humidityValue > 50) {
        cropRecommendation = 'Recommended Crops: Lettuce, Spinach, Carrots';
      } else if (temperature > 10 && humidityValue <= 50) {
        cropRecommendation = 'Recommended Crops: Broccoli, Cauliflower, Kale';
      } else {
        cropRecommendation = 'Recommendations vary with specific conditions. Check local guidelines.';
      }
    } else {
      cropRecommendation = 'Fetching weather data...';
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Crop Recommendations Based on Current Weather',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              cropRecommendation,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[800]),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}

