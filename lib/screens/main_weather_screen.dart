import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../widgets/glassmorphism_widget.dart';
import 'weather_search_screen.dart';

class MainWeatherScreen extends StatefulWidget {
  const MainWeatherScreen({super.key});

  @override
  State<MainWeatherScreen> createState() => _MainWeatherScreenState();
}

class _MainWeatherScreenState extends State<MainWeatherScreen> {
  bool isDaySelected = true;

  final WeatherModel currentWeather = WeatherModel(
    location: 'Lahore, Pakistan',
    temperature: 20,
    condition: 'Rainy',
    highTemp: 20,
    lowTemp: 4,
    weatherIcon: 'assets/images/rain2.gif',
  );

  final List<HourlyWeather> hourlyForecast = [
    HourlyWeather(
      time: 'NOW',
      temperature: 20,
      weatherIcon: 'assets/images/rain2.gif',
      isNow: true,
    ),
    HourlyWeather(
      time: '11AM',
      temperature: 20,
      weatherIcon: 'assets/images/rain2.gif',
    ),
    HourlyWeather(
      time: '12PM',
      temperature: 19,
      weatherIcon: 'assets/images/cloudy.gif',
    ),
    HourlyWeather(
      time: '1PM',
      temperature: 18,
      weatherIcon: 'assets/images/cloudy.gif',
    ),
    HourlyWeather(
      time: '2PM',
      temperature: 17,
      weatherIcon: 'assets/images/cloudy.gif',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Status Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '9:41',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 18),
                        const SizedBox(width: 5),
                        Icon(Icons.wifi, color: Colors.white, size: 18),
                        const SizedBox(width: 5),
                        Icon(Icons.battery_full, color: Colors.white, size: 18),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Location
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    currentWeather.location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Main Weather Display
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      
                      // Weather Card
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF6A5ACD).withOpacity(0.6),
                              const Color(0xFF836FFF).withOpacity(0.6),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currentWeather.location,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    '${currentWeather.temperature}°',
                                    style: TextStyle(
                                      fontSize: 36,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currentWeather.condition,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),

                              // Icon
                              Image.asset(
                                currentWeather.weatherIcon,
                                height: 70,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Day/Week Toggle
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 150),
                        child: GlassmorphismWidget(
                          borderRadius: BorderRadius.circular(30),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildToggleButton('Day', isDaySelected),
                              _buildToggleButton('WEEK', !isDaySelected),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Hourly Forecast
                      SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: hourlyForecast.length,
                          itemBuilder: (context, index) {
                            final hour = hourlyForecast[index];
                            return Container(
                              width: 90,
                              margin: const EdgeInsets.only(right: 15),
                              child: GlassmorphismWidget(
                                borderRadius: BorderRadius.circular(50),
                                opacity: hour.isNow ? 0.3 : 0.2,
                                borderColor: hour.isNow
                                    ? Colors.purple.withOpacity(0.8)
                                    : Colors.white.withOpacity(0.3),
                                borderWidth: hour.isNow ? 2.0 : 1.0,
                                child: Container(
                                  decoration: hour.isNow
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.purple.withOpacity(0.5),
                                              blurRadius: 20,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        )
                                      : null,
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        hour.time,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 14,
                                          fontWeight: hour.isNow
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(
                                          hour.weatherIcon,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${hour.temperature}°',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isDaySelected = text == 'Day';
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.purple.withOpacity(0.5)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: GlassmorphismWidget(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.explore, color: Colors.white),
                onPressed: () {},
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.withOpacity(0.8),
                      Colors.blue.withOpacity(0.8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white, size: 28),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeatherSearchScreen(),
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

