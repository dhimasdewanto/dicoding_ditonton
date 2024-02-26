import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/tv/get_on_the_air_tv.dart';

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
            movies: moviesData,
            state: RequestState.loaded,
          ),
        );
      },
    );
  }
}