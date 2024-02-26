import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_watchlist_items.dart';

part 'watchlist_list_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit({
    required this.getWatchlistItems,
  }) : super(const WatchlistState());

  final GetWatchlistItems getWatchlistItems;

  Future<void> fetch() async {
    if (state.state == RequestState.loading) {
      return;
    }
    emit(state.copyWith(state: RequestState.loading));

    final result = await getWatchlistItems();
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