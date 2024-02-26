import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/movie/get_watchlist_movies.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  WatchlistMovieCubit({
    required this.getWatchlistMovies,
  }) : super(const WatchlistMovieState());

  final GetWatchlistMovies getWatchlistMovies;

  Future<void> fetch() async {
    if (state.state == RequestState.loading) {
      return;
    }
    emit(state.copyWith(state: RequestState.loading));

    final result = await getWatchlistMovies();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            message: failure.message,
            state: RequestState.error,
          ),
        );
      },
      (moviesData) {
        emit(
          state.copyWith(
            movies: moviesData,
            state: RequestState.loaded,
          ),
        );
      },
    );
  }
}