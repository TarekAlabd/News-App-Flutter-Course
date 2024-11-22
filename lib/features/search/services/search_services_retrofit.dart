import 'package:dio/dio.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'search_services_retrofit.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl) // Annotation @
abstract class SearchServicesRetrofit {
  factory SearchServicesRetrofit(Dio dio, {String? baseUrl}) =
      _SearchServicesRetrofit;

  @GET(AppConstants.everything)
  Future<NewsApiResponse> search(
    @Query('q') String q,
    @Query('page') int page,
    @Query('pageSize') int pageSize,
    @Query('searchIn') String searchIn,
    @Header('Authorization') String apiKey,
  );
}
