import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/tv/search_tv.dart';

part 'tv_search_state.dart';

class TvSearchCubit extends Cubit<TvSearchState> {
  TvSearchCubit({
    required this.searchTv,
  }) : super(const TvSearchState());

  final SearchTv searchTv;

  Future<void> fetch(String query) async {
    if (state.state == RequestState.loading) {
      return;
    }
    emit(state.copyWith(state: RequestState.loading));

    final result = await searchTv(query);
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
