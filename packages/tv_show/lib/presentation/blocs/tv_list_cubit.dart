import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

import '../../domain/usecases/get_on_the_air_tv.dart';
import '../../domain/usecases/get_popular_tv.dart';
import '../../domain/usecases/get_top_rated_tv.dart';

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

  Future<void> fetchOnTheAir() async {
    if (state.stateOnTheAir == RequestState.loading) {
      return;
    }
    emit(state.copyWith(stateOnTheAir: RequestState.loading));

    final result = await getOnTheAirTv();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            message: failure.message,
            stateOnTheAir: RequestState.error,
          ),
        );
      },
      (moviesData) {
        emit(
          state.copyWith(
            showsOnTheAir: moviesData,
            stateOnTheAir: RequestState.loaded,
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
            showsPopular: moviesData,
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
            showsTopRated: moviesData,
            stateTopRated: RequestState.loaded,
          ),
        );
      },
    );
  }
}