import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/features/home/models/top_headlines_body.dart';
import 'package:news_app/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServices();

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
      emit(RecommendedNewsLoaded(result.articles));
    } catch (e) {
      emit(RecommendedNewsError(e.toString()));
    }
  }
}
