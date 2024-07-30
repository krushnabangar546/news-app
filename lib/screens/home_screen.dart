import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helpers/colors.dart';
import 'package:news_app/helpers/field_styles.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_tiles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: KLText(sText: 'MyNews', textSize: 24.0, textColor: bgColor, textBold: 5),
        backgroundColor: kPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.near_me, color: Colors.white),
                SizedBox(width: 8),
                KLText(sText: newsProvider.countryCode, textSize: 18.0, textColor: bgColor, textBold: 5),
                SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (newsProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(newsProvider.errorMessage));
          } else if (newsProvider.articles.isEmpty) {
            return Center(child: Text('No articles available'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: KLText(sText: 'Top Headlines', textSize: 18.0, textColor: Colors.black, textBold: 6),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: newsProvider.articles.length,
                    itemBuilder: (context, index) {
                      return NewsTile(article: newsProvider.articles[index]);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

