import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/services/local_database_hive.dart';
import 'package:news_app/core/services/local_database_services.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/home/models/top_headlines_body.dart';
import 'package:news_app/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServices();
  // final localDatabaseServices = LocalDatabaseServices();
  final localDatabaseHive = LocalDatabaseHive();

  Future<void> getTopHeadlines() async {
    emit(TopHeadlinesLoading());
    try {
      const body = TopHeadlinesBody(
        category: 'business',
        page: 1,
        pageSize: 7,
      );
      final result = await homeServices.getTopHeadlines(body);
      emit(TopHeadlinesLoaded(result.articles));
    } catch (e) {
      emit(TopHeadlinesError(e.toString()));
    }
  }

  Future<void> getRecommendationItems() async {
    emit(RecommendedNewsLoading());
    try {
      const body = TopHeadlinesBody(
        page: 1,
        pageSize: 15,
      );
      final result = await homeServices.getTopHeadlines(body);
      final articles = result.articles ?? [];
      final favArticles = await _getFavorites();

      for (int i = 0; i < articles.length; i++) {
        var article = articles[i];
        final isFound =
            favArticles.any((element) => element.title == article.title);
        if (isFound) {
          article = article.copyWith(isFavorite: true);
          articles[i] = article;
        }
      }
      emit(RecommendedNewsLoaded(articles));
    } catch (e) {
      emit(RecommendedNewsError(e.toString()));
    }
  }

  Future<List<Article>> _getFavorites() async {
    // final favorites = await localDatabaseServices.getStringList(
    //   AppConstants.favoritesKey,
    // );
    final favorites = await localDatabaseHive.getData<List<Article>?>(
      AppConstants.favoritesKey,
    );
    // final List<Article> favArticles = [];
    // if (favorites != null) {
    //   for (var favArticleString in favorites) {
    //     final favArticle = Article.fromJson(favArticleString);
    //     favArticles.add(favArticle);
    //   }
    // }
    return favorites ?? [];
  }
}
