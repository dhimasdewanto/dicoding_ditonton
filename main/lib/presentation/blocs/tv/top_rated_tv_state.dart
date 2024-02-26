part of 'top_rated_tv_cubit.dart';

class TopRatedTvState extends Equatable {
  final RequestState state;
  final List<Movie> movies;
  final String message;

  const TopRatedTvState({
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

  TopRatedTvState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return TopRatedTvState(
      state: state ?? this.state,
      movies: movies ?? this.movies,
      message: message ?? this.message,
    );
  }
}
