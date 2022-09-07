import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_model.dart';
import 'package:http/http.dart' as http;


final String _URL_NEWS = 'https://newsapi.org/v2';
final String _API_KEY = '79bbd26fffe046fea3c7127dea58b2bc';

class NewsService with ChangeNotifier{

  List<Article> headlines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'Business'),
    Category( FontAwesomeIcons.tv, 'entertainment'),
    Category( FontAwesomeIcons.addressCard, 'general'),
    Category( FontAwesomeIcons.headSideVirus, 'health'),
    Category( FontAwesomeIcons.vials, 'science'),
    Category( FontAwesomeIcons.futbol, 'sports'),
    Category( FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};


  NewsService(){
    this.getTopHeadlines();

    categories.forEach((element) {
      categoryArticles[element.name] = [];
    });

  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory( String value) {
    _selectedCategory = value;
  
    getArticlesByCategory(value);
    notifyListeners();
  }


  getTopHeadlines()async{
    print('Loading Headlines.....');
    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=us';
    final uri = Uri.parse(url);
    final resp = await http.get(uri);
    


    final newsResponse = NewsResponse.fromJson(resp.body);
    
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory( String category)async{

    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=us&category=$category';
    final uri = Uri.parse(url);
    final resp = await http.get(uri);
    


    final newsResponse = NewsResponse.fromJson(resp.body);
    categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }


  }



