part of 'tv_detail_cubit.dart';

class TvDetailState extends Equatable {
  final RequestState movieState;
  final TvShowDetail? tvShow;
  final RequestState recommendationState;
  final List<TvShow> recommendations;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  const TvDetailState({
    this.movieState = RequestState.empty,
    this.tvShow,
    this.recommendationState = RequestState.empty,
    this.recommendations = const [],
    this.isAddedToWatchlist = false,
    this.message = "",
    this.watchlistMessage = "",
  });

  @override
  List<Object?> get props => [
        movieState,
        tvShow,
        recommendationState,
        recommendations,
        isAddedToWatchlist,
        message,
        watchlistMessage,
      ];

  TvDetailState copyWith({
    RequestState? movieState,
    ValueGetter<TvShowDetail?>? tvShow,
    RequestState? recommendationState,
    List<TvShow>? recommendations,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return TvDetailState(
      movieState: movieState ?? this.movieState,
      tvShow: tvShow != null ? tvShow() : this.tvShow,
      recommendationState: recommendationState ?? this.recommendationState,
      recommendations: recommendations ?? this.recommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }
}
