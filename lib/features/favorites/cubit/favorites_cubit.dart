import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cubit/favorite_actions/favorite_actions_cubit.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/features/favorites/services/favorites_services.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial()) {
    favoriteActionsCubit.stream.listen((state) {
      if (state is FavoriteRemoved) {
        getFavoriteItems();
      }
    });
  }

  final favoritesServices = FavoritesServices();
  final favoriteActionsCubit = FavoriteActionsCubit();

  Future<void> getFavoriteItems() async {
    emit(FavoritesLoading());
    try {
      final favArticles = await favoritesServices.getFavorites();
      for (int index = 0; index < favArticles.length; index++) {
        var article = favArticles[index];
        article = article.copyWith(isFavorite: true);
        favArticles[index] = article;
      }
      emit(FavoritesLoaded(favArticles));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
