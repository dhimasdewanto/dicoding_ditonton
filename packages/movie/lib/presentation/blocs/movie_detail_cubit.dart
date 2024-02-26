import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    // required this.getWatchListStatus,
    // required this.saveWatchlist,
    // required this.removeWatchlist,
  }) : super(const MovieDetailState());

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  // final GetWatchListStatus getWatchListStatus;
  // final SaveWatchlist saveWatchlist;
  // final RemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<void> fetch(int id) async {
    if (state.movieState == RequestState.loading) {
      return;
    }
    emit(state.copyWith(movieState: RequestState.loading));

    final detailResult = await getMovieDetail(id);
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
            movie: () => movie,
          ),
        );

        final recommendationResult = await getMovieRecommendations(id);
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

  Future<void> addWatchlist(MovieDetail movie) async {
    // final result = await saveWatchlist(movie.toMovie());
    // await result.fold(
    //   (failure) async {
    //     emit(state.copyWith(watchlistMessage: failure.message));
    //   },
    //   (successMessage) async {
    //     emit(state.copyWith(watchlistMessage: successMessage));
    //   },
    // );
    // await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    // final result = await removeWatchlist(movie.toMovie());
    // await result.fold(
    //   (failure) async {
    //     emit(state.copyWith(watchlistMessage: failure.message));
    //   },
    //   (successMessage) async {
    //     emit(state.copyWith(watchlistMessage: successMessage));
    //   },
    // );
    // await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    // final isAddedToWatchlist = await getWatchListStatus(id);
    // emit(
    //   state.copyWith(
    //     isAddedToWatchlist: isAddedToWatchlist,
    //   ),
    // );
  }
}
