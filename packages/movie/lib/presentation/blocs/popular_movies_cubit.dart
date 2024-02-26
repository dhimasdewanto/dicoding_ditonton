import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movies.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit({
    required this.getPopularMovies,
  }) : super(const PopularMoviesState());

  final GetPopularMovies getPopularMovies;

  Future<void> fetch() async {
    if (state.state == RequestState.loading) {
      return;
    }
    emit(state.copyWith(state: RequestState.loading));

    final result = await getPopularMovies();
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