import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_model.dart';

class NewsService with ChangeNotifier{

  List<Article> headlines = [];

  NewsService(){


    this.getTopHeadlines();
  }


  getTopHeadlines(){
    print('Loading Headlines...');
  }

}

