part of 'home_cubit.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}

final class TopHeadlinesLoading extends HomeState {}

final class TopHeadlinesLoaded extends HomeState {
  final List<Article>? articles;

  const TopHeadlinesLoaded(this.articles);
}

final class TopHeadlinesError extends HomeState {
  final String message;

  const TopHeadlinesError(this.message);
}

final class RecommendedNewsLoading extends HomeState {}

final class RecommendedNewsLoaded extends HomeState {
  final List<Article>? articles;

  const RecommendedNewsLoaded(this.articles);
}

final class RecommendedNewsError extends HomeState {
  final String message;

  const RecommendedNewsError(this.message);
}

final class FavoriteLoading extends HomeState {
  final String title;

  const FavoriteLoading(this.title);
}

final class FavoriteAdded extends HomeState {
  final String title;

  const FavoriteAdded(this.title);
}

final class FavoriteRemoved extends HomeState {
  final String title;

  const FavoriteRemoved(this.title);
}

final class FavoriteError extends HomeState {
  final String message;
  final String title;

  const FavoriteError(this.message, this.title);
}
