import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import '../services/news_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _newsService = NewsService();
  List<dynamic> _articles = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _countryCode = '';

  List<dynamic> get articles => _articles;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get countryCode => _countryCode;

  Future<void> initialize() async {
    _countryCode = await getCountryCode();
    await fetchTopHeadlines(_countryCode);
  }

  Future<String> getCountryCode() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration(minutes: 1),
      ));
      await remoteConfig.fetchAndActivate();
      return remoteConfig.getString('country_code');
    } catch (e) {
      print('Remote Config fetch failed: $e');
      return '';
    }
  }

  Future<void> fetchTopHeadlines(String countryCode) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _articles = await _newsService.fetchTopHeadlines(countryCode);
      print('response data: ' + _articles.toString());
    } catch (error) {
      _errorMessage = 'Failed to load news: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
