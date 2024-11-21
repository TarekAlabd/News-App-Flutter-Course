part of 'search_cubit.dart';

sealed class SearchState {
  const SearchState();
}

final class SearchInitial extends SearchState {}

final class SearchResultsLoaded extends SearchState {
  final List<Article> articles;

  const SearchResultsLoaded(this.articles);
}

final class SearchResultsError extends SearchState {
  final String message;

  const SearchResultsError(this.message);
}

final class Searching extends SearchState {}
