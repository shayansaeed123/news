
import 'dart:convert';

import '../model/categories_news_model.dart';
import '../model/news_channel_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository{

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlineApi(String channelName)async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=deb43f06e1f54aacb0fac132a4ada187';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return NewsChannelHeadlinesModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String categoryName)async{
    String url = 'https://newsapi.org/v2/everything?q=${categoryName}&apiKey=deb43f06e1f54aacb0fac132a4ada187';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return CategoriesNewsModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
  }
}