import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/tv/get_on_the_air_tv.dart';
import '../../../domain/usecases/tv/get_popular_tv.dart';
import '../../../domain/usecases/tv/get_top_rated_tv.dart';

part 'tv_list_state.dart';

class TvListCubit extends Cubit<TvListState> {
  TvListCubit({
    required this.getOnTheAirTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  }) : super(const TvListState());

  final GetOnTheAirTv getOnTheAirTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchNowPlaying() async {
    if (state.stateNowPlaying == RequestState.loading) {
      return;
    }
    emit(state.copyWith(stateNowPlaying: RequestState.loading));

    final result = await getOnTheAirTv();
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

    final result = await getPopularTv();
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

    final result = await getTopRatedTv();
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