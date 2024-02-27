import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

import '../../domain/usecases/get_on_the_air_tv.dart';

part 'on_the_air_tv_state.dart';

class OnTheAirTvCubit extends Cubit<OnTheAirTvState> {
  OnTheAirTvCubit({
    required this.getOnTheAirTv,
  }) : super(const OnTheAirTvState());

  final GetOnTheAirTv getOnTheAirTv;

  Future<void> fetch() async {
    if (state.state == RequestState.loading) {
      return;
    }
    emit(state.copyWith(state: RequestState.loading));

    final result = await getOnTheAirTv();
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
            shows: moviesData,
            state: RequestState.loaded,
          ),
        );
      },
    );
  }
}