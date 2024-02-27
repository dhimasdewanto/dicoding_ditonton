import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

import '../../domain/usecases/get_popular_tv.dart';

part 'popular_tv_state.dart';

class PopularTvCubit extends Cubit<PopularTvState> {
  PopularTvCubit({
    required this.getPopularTv,
  }) : super(const PopularTvState());

  final GetPopularTv getPopularTv;

  Future<void> fetch() async {
    if (state.state == RequestState.loading) {
      return;
    }
    emit(state.copyWith(state: RequestState.loading));

    final result = await getPopularTv();
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