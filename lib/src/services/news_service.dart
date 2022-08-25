import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_model.dart';
import 'package:http/http.dart' as http;


final _URL_NEWS = 'https://newsapi.org/v2';
final _API_KEY = '79bbd26fffe046fea3c7127dea58b2bc';

class NewsService with ChangeNotifier{

  List<Article> headlines = [];

  NewsService(){


    this.getTopHeadlines();
  }


  getTopHeadlines()async{
    print('Loading Headlines...');
    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=us';
    final uri = Uri.parse(url);
    final resp = await http.get(uri);

    final newsResponse = NewsResponse.fromJson(resp.body);
    
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

}

