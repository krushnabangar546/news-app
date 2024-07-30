import 'package:flutter/material.dart';
import 'package:news_app/helpers/colors.dart';
import 'package:news_app/helpers/field_styles.dart';

class NewsTile extends StatelessWidget {
  final dynamic article;

  NewsTile({required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        elevation: 5,
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(8, 10, 8, 0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KLText(
                      sText: article['source']['name'] ?? 'no source',
                      textSize: 18,
                      textColor: Colors.black,
                      textBold: 6,
                    ),
                    SizedBox(height: 8.0),
                    KLText(
                      sText: article['title'] ?? 'No Title',
                      textSize: 16.0,
                      textColor: Colors.black,
                      textBold: 2,
                    ),
                  ],
                ),
              ),
              if (article['urlToImage'] != null)
                Container(
                  width: 100,
                  height: 120,
                  child: Image.network(
                    article['urlToImage'],
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
