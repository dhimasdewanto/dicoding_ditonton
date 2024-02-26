import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/movie/get_now_playing_movies.dart';
import '../../../domain/usecases/movie/get_popular_movies.dart';
import '../../../domain/usecases/movie/get_top_rated_movies.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  MovieListCubit({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(const MovieListState());

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  Future<void> fetchNowPlaying() async {
    if (state.stateNowPlaying == RequestState.loading) {
      return;
    }
    emit(state.copyWith(stateNowPlaying: RequestState.loading));

    final result = await getNowPlayingMovies();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            message: failure.message,
            stateNowPlaying: RequestState.error,
          ),
        );
      },
      (moviesData) {
        emit(
          state.copyWith(
            moviesNowPlaying: moviesData,
            stateNowPlaying: RequestState.loaded,
          ),
        );
      },
    );
  }

  Future<void> fetchPopular() async {
    if (state.statePopular == RequestState.loading) {
      return;
    }
    emit(state.copyWith(statePopular: RequestState.loading));

    final result = await getPopularMovies();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            message: failure.message,
            statePopular: RequestState.error,
          ),
        );
      },
      (moviesData) {
        emit(
          state.copyWith(
            moviesPopular: moviesData,
            statePopular: RequestState.loaded,
          ),
        );
      },
    );
  }

  Future<void> fetchTopRated() async {
    if (state.stateTopRated == RequestState.loading) {
      return;
    }
    emit(state.copyWith(stateTopRated: RequestState.loading));

    final result = await getTopRatedMovies();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            message: failure.message,
            stateTopRated: RequestState.error,
          ),
        );
      },
      (moviesData) {
        emit(
          state.copyWith(
            moviesTopRated: moviesData,
            stateTopRated: RequestState.loaded,
          ),
        );
      },
    );
  }
}