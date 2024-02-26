part of 'on_the_air_tv_cubit.dart';

class OnTheAirTvState extends Equatable {
  final RequestState state;
  final List<Movie> movies;
  final String message;

  const OnTheAirTvState({
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

  OnTheAirTvState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return OnTheAirTvState(
      state: state ?? this.state,
      movies: movies ?? this.movies,
      message: message ?? this.message,
    );
  }
}
