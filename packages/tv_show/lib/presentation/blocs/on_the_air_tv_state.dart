part of 'on_the_air_tv_cubit.dart';

class OnTheAirTvState extends Equatable {
  final RequestState state;
  final List<TvShow> shows;
  final String message;

  const OnTheAirTvState({
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

  OnTheAirTvState copyWith({
    RequestState? state,
    List<TvShow>? shows,
    String? message,
  }) {
    return OnTheAirTvState(
      state: state ?? this.state,
      shows: shows ?? this.shows,
      message: message ?? this.message,
    );
  }
}
