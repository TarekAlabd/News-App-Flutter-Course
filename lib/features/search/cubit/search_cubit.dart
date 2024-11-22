import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/search/models/search_body.dart';
import 'package:news_app/features/search/services/search_services.dart';
import 'package:news_app/features/search/services/search_services_retrofit.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final searchServices = SearchServices();
  final searchServicesRetrofit = SearchServicesRetrofit(
    Dio(),
  );

  Future<void> search(String keyword) async {
    emit(Searching());
    try {
      final body = SearchBody(
        q: keyword,
      );
      final response = await searchServicesRetrofit.search(
        body.q,
        body.page,
        body.pageSize,
        body.searchIn,
        'Bearer ${AppConstants.apiKey}',
      );
      emit(SearchResultsLoaded(response.articles ?? []));
    } catch (e) {
      emit(SearchResultsError(e.toString()));
    }
  }
}
