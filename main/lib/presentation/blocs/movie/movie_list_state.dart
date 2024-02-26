part of 'movie_list_cubit.dart';

class MovieListState extends Equatable {
  final RequestState stateNowPlaying;
  final List<Movie> moviesNowPlaying;
  final RequestState statePopular;
  final List<Movie> moviesPopular;
  final RequestState stateTopRated;
  final List<Movie> moviesTopRated;
  final String message;

  const MovieListState({
    this.stateNowPlaying = RequestState.empty,
    this.moviesNowPlaying = const [],
    this.statePopular = RequestState.empty,
    this.moviesPopular = const [],
    this.stateTopRated = RequestState.empty,
    this.moviesTopRated = const [],
    this.message = "",
  });

  @override
  List<Object?> get props => [
        stateNowPlaying,
        moviesNowPlaying,
        statePopular,
        moviesPopular,
        stateTopRated,
        moviesTopRated,
        message,
      ];

  MovieListState copyWith({
    RequestState? stateNowPlaying,
    List<Movie>? moviesNowPlaying,
    RequestState? statePopular,
    List<Movie>? moviesPopular,
    RequestState? stateTopRated,
    List<Movie>? moviesTopRated,
    String? message,
  }) {
    return MovieListState(
      stateNowPlaying: stateNowPlaying ?? this.stateNowPlaying,
      moviesNowPlaying: moviesNowPlaying ?? this.moviesNowPlaying,
      statePopular: statePopular ?? this.statePopular,
      moviesPopular: moviesPopular ?? this.moviesPopular,
      stateTopRated: stateTopRated ?? this.stateTopRated,
      moviesTopRated: moviesTopRated ?? this.moviesTopRated,
      message: message ?? this.message,
    );
  }
}
