import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsService {
  final String _apiKey = 'a0cc35eb42dc44b18e7946c778149b7d';

  Future<List<dynamic>> fetchTopHeadlines(String countryCode) async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=$_apiKey'
    );

    print('url'+url.toString());

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['articles'];
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}
