import 'dart:convert';
import 'package:http/http.dart' as http;

class CityService {
  // To get your RapidAPI key:
  // 1. Go to https://rapidapi.com/wirefreethought/api/geodb-cities
  // 2. Click "Subscribe to Test" (free tier available)
  // 3. Copy your API key from the "Code Snippets" section
  // 4. Paste it below (make sure there are no extra spaces or quotes)
  static const String _apiKey = 'e82481e7c6mshb00aa82ec1a8f49p1c954cjsn6fbab9b5808a';
  static const String _host = 'wft-geo-db.p.rapidapi.com';

  static Future<List<dynamic>> searchCities(String query) async {
    final url = Uri.parse(
      'https://$_host/v1/geo/cities?namePrefix=$query&limit=5',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-key': _apiKey,
          'x-rapidapi-host': _host,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final citiesList = data['data'] as List<dynamic>?;
        if (citiesList != null && citiesList.isNotEmpty) {
          return citiesList;
        } else {
          return [];
        }
      } else if (response.statusCode == 401) {
        final errorBody = response.body;
        throw Exception('Invalid API key (401). Please check:\n'
            '1. Your RapidAPI key is correct\n'
            '2. You have subscribed to "GeoDB Cities" API on RapidAPI\n'
            '3. The key has no extra spaces or quotes\n'
            'Response: $errorBody');
      } else if (response.statusCode == 403) {
        throw Exception('API access forbidden. Check your RapidAPI subscription.');
      } else if (response.statusCode == 429) {
        throw Exception('Too many requests. Please try again later.');
      } else {
        throw Exception('Failed to load cities (Status: ${response.statusCode}). ${response.body}');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }

  static Future<Map<String, dynamic>> getWeather(double lat, double lon) async {
    // To get your OpenWeatherMap API key (FREE):
    // 1. Go to https://openweathermap.org/api
    // 2. Click "Sign Up" or "Sign In" if you have an account
    // 3. After signing up, go to https://home.openweathermap.org/api_keys
    // 4. Create a new API key (it's free, no credit card required)
    // 5. Copy the API key and paste it below
    const apiKey = 'b5ac5fbdc91c8889b86d73d2e8300d16';

    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather'
      '?lat=$lat&lon=$lon&units=metric&lang=ar&appid=$apiKey',
    );

    try {
      print('Fetching weather from: ${url.toString().replaceAll(apiKey, '***HIDDEN***')}');
      final response = await http.get(url);
      print('Weather API response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 401) {
        final errorBody = response.body;
        throw Exception('Invalid OpenWeatherMap API key (401).\n'
            'Possible reasons:\n'
            '1. API key is incorrect or has typos\n'
            '2. New API key may take up to 2 hours to activate\n'
            '3. API key might be suspended or expired\n'
            '4. Check your API key at: https://home.openweathermap.org/api_keys\n'
            'Response: $errorBody');
      } else if (response.statusCode == 404) {
        throw Exception('Weather data not found for this location.');
      } else {
        throw Exception('Failed to load weather (Status: ${response.statusCode}). ${response.body}');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }
}

