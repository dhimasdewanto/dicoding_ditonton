part of 'top_rated_tv_cubit.dart';

class TopRatedTvState extends Equatable {
  final RequestState state;
  final List<TvShow> shows;
  final String message;

  const TopRatedTvState({
    this.state = RequestState.empty,
    this.shows = const [],
    this.message = "",
  });

  @override
  List<Object?> get props => [
        state,
        shows,
        message,
      ];

  TopRatedTvState copyWith({
    RequestState? state,
    List<TvShow>? shows,
    String? message,
  }) {
    return TopRatedTvState(
      state: state ?? this.state,
      shows: shows ?? this.shows,
      message: message ?? this.message,
    );
  }
}
