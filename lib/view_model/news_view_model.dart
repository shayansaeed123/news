

import 'package:news/model/categories_news_model.dart';
import 'package:news/repository/news_repository.dart';

import '../model/news_channel_headlines_model.dart';

class NewsViewModel{

  final _rep = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlineApi(String channelName)async{

    final reponse = await _rep.fetchNewsChannelHeadlineApi(channelName);
    return reponse;

  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String categoryName)async{

    final reponse = await _rep.fetchCategoriesNewsApi(categoryName);
    return reponse;

  }
}