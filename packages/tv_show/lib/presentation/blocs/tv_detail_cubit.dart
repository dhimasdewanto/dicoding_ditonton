import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/entities/tv_show_detail.dart';
import 'package:watchlist/watchlist.dart';

import '../../domain/entities/tv_show.dart';
import '../../domain/usecases/get_tv_detail.dart';
import '../../domain/usecases/get_tv_recommendations.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  TvDetailCubit({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const TvDetailState());

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<void> fetch(int id) async {
    if (state.movieState == RequestState.loading) {
      return;
    }
    emit(state.copyWith(movieState: RequestState.loading));

    final detailResult = await getTvDetail(id);
    await detailResult.fold(
      (failure) {
        emit(
          state.copyWith(
            movieState: RequestState.error,
            message: failure.message,
          ),
        );
      },
      (movie) async {
        emit(
          state.copyWith(
            movieState: RequestState.loaded,
            tvShow: () => movie,
          ),
        );

        final recommendationResult = await getTvRecommendations(id);
        recommendationResult.fold(
          (failure) {
            emit(
              state.copyWith(
                recommendationState: RequestState.error,
                message: failure.message,
              ),
            );
          },
          (movies) {
            emit(
              state.copyWith(
                recommendationState: RequestState.loaded,
                recommendations: movies,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> addWatchlist(TvShow tvShow) async {
    final result = await saveWatchlist(toWatchlist(tvShow));
    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );
    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> removeFromWatchlist(TvShow tvShow) async {
    final result = await removeWatchlist(toWatchlist(tvShow));
    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );
    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final isAddedToWatchlist = await getWatchListStatus(id);
    emit(
      state.copyWith(
        isAddedToWatchlist: isAddedToWatchlist,
      ),
    );
  }

  Watchlist toWatchlist(TvShow tv) {
    return Watchlist(
      type: ShowType.tv,
      id: tv.id,
      overview: tv.overview,
      posterPath: tv.posterPath,
      title: tv.title,
    );
  }
}
