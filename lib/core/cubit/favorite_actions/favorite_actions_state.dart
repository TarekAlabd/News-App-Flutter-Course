part of 'favorite_actions_cubit.dart';

sealed class FavoriteActionsState {
  const FavoriteActionsState();
}

final class FavoriteActionsInitial extends FavoriteActionsState {}

final class DoingFavorite extends FavoriteActionsState {
  final String title;

  const DoingFavorite(this.title);
}

final class FavoriteAdded extends FavoriteActionsState {
  final String title;

  const FavoriteAdded(this.title);
}

final class FavoriteRemoved extends FavoriteActionsState {
  final String title;

  const FavoriteRemoved(this.title);
}

final class DoingFavoriteError extends FavoriteActionsState {
  final String message;
  final String title;

  const DoingFavoriteError(this.message, this.title);
}
