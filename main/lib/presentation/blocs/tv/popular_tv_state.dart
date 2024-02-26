part of 'popular_tv_cubit.dart';

class PopularTvState extends Equatable {
  final RequestState state;
  final List<Movie> movies;
  final String message;

  const PopularTvState({
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

  PopularTvState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return PopularTvState(
      state: state ?? this.state,
      movies: movies ?? this.movies,
      message: message ?? this.message,
    );
  }
}
