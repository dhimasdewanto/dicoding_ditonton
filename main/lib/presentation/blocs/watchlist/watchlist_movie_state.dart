part of 'watchlist_movie_cubit.dart';

class WatchlistMovieState extends Equatable {
  final RequestState state;
  final List<Movie> movies;
  final String message;

  const WatchlistMovieState({
    this.state = RequestState.empty,
    this.movies = const [],
    this.message = "",
  });

  @override
  List<Object?> get props => [
        state,
        movies,
        message,
      ];

  WatchlistMovieState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return WatchlistMovieState(
      state: state ?? this.state,
      movies: movies ?? this.movies,
      message: message ?? this.message,
    );
  }
}
