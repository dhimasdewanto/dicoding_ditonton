part of 'tv_list_cubit.dart';

class TvListState extends Equatable {
  final RequestState stateOnTheAir;
  final List<TvShow> showsOnTheAir;
  final RequestState statePopular;
  final List<TvShow> showsPopular;
  final RequestState stateTopRated;
  final List<TvShow> showsTopRated;
  final String message;

  const TvListState({
    this.stateOnTheAir = RequestState.empty,
    this.showsOnTheAir = const [],
    this.statePopular = RequestState.empty,
    this.showsPopular = const [],
    this.stateTopRated = RequestState.empty,
    this.showsTopRated = const [],
    this.message = "",
  });

  @override
  List<Object?> get props => [
        stateOnTheAir,
        showsOnTheAir,
        statePopular,
        showsPopular,
        stateTopRated,
        showsTopRated,
        message,
      ];

  TvListState copyWith({
    RequestState? stateOnTheAir,
    List<TvShow>? showsOnTheAir,
    RequestState? statePopular,
    List<TvShow>? showsPopular,
    RequestState? stateTopRated,
    List<TvShow>? showsTopRated,
    String? message,
  }) {
    return TvListState(
      stateOnTheAir: stateOnTheAir ?? this.stateOnTheAir,
      showsOnTheAir: showsOnTheAir ?? this.showsOnTheAir,
      statePopular: statePopular ?? this.statePopular,
      showsPopular: showsPopular ?? this.showsPopular,
      stateTopRated: stateTopRated ?? this.stateTopRated,
      showsTopRated: showsTopRated ?? this.showsTopRated,
      message: message ?? this.message,
    );
  }
}
