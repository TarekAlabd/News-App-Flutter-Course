part of 'favorites_cubit.dart';

sealed class FavoritesState {
    const FavoritesState();
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
    final List<Article> articles;
    
    const FavoritesLoaded(this.articles);
}

final class FavoritesError extends FavoritesState {
    final String message;
    
    const FavoritesError(this.message);
}
