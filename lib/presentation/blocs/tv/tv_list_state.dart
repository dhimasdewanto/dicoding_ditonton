part of 'tv_list_cubit.dart';

class TvListState extends Equatable {
  final RequestState stateOnTheAir;
  final List<Movie> moviesOnTheAir;
  final RequestState statePopular;
  final List<Movie> moviesPopular;
  final RequestState stateTopRated;
  final List<Movie> moviesTopRated;
  final String message;

  const TvListState({
    this.stateOnTheAir = RequestState.empty,
    this.moviesOnTheAir = const [],
    this.statePopular = RequestState.empty,
    this.moviesPopular = const [],
    this.stateTopRated = RequestState.empty,
    this.moviesTopRated = const [],
    this.message = "",
  });

  @override
  List<Object?> get props => [
        stateOnTheAir,
        moviesOnTheAir,
        statePopular,
        moviesPopular,
        stateTopRated,
        moviesTopRated,
        message,
      ];

  TvListState copyWith({
    RequestState? stateOnTheAir,
    List<Movie>? moviesOnTheAir,
    RequestState? statePopular,
    List<Movie>? moviesPopular,
    RequestState? stateTopRated,
    List<Movie>? moviesTopRated,
    String? message,
  }) {
    return TvListState(
      stateOnTheAir: stateOnTheAir ?? this.stateOnTheAir,
      moviesOnTheAir: moviesOnTheAir ?? this.moviesOnTheAir,
      statePopular: statePopular ?? this.statePopular,
      moviesPopular: moviesPopular ?? this.moviesPopular,
      stateTopRated: stateTopRated ?? this.stateTopRated,
      moviesTopRated: moviesTopRated ?? this.moviesTopRated,
      message: message ?? this.message,
    );
  }
}
