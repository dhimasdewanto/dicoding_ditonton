import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/movie/search_movies.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit({
    required this.searchMovies,
  }) : super(const MovieSearchState());

  final SearchMovies searchMovies;

  Future<void> fetch(String query) async {
    if (state.state == RequestState.loading) {
      return;
    }
    emit(state.copyWith(state: RequestState.loading));

    final result = await searchMovies(query);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            message: failure.message,
            state: RequestState.error,
          ),
        );
      },
      (resultData) {
        emit(
          state.copyWith(
            searchResults: resultData,
            state: RequestState.loaded,
          ),
        );
      },
    );
  }
}
