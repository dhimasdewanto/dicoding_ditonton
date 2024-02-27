part of 'popular_tv_cubit.dart';

class PopularTvState extends Equatable {
  final RequestState state;
  final List<TvShow> shows;
  final String message;

  const PopularTvState({
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

  PopularTvState copyWith({
    RequestState? state,
    List<TvShow>? shows,
    String? message,
  }) {
    return PopularTvState(
      state: state ?? this.state,
      shows: shows ?? this.shows,
      message: message ?? this.message,
    );
  }
}
