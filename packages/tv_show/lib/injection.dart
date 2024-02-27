import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/tv_remote_data_source.dart';
import 'data/repositories/tv_repository_impl.dart';
import 'domain/repositories/tv_repository.dart';
import 'domain/usecases/get_on_the_air_tv.dart';
import 'domain/usecases/get_popular_tv.dart';
import 'domain/usecases/get_top_rated_tv.dart';
import 'domain/usecases/get_tv_detail.dart';
import 'domain/usecases/get_tv_recommendations.dart';
import 'domain/usecases/search_tv.dart';
import 'presentation/blocs/on_the_air_tv_cubit.dart';
import 'presentation/blocs/popular_tv_cubit.dart';
import 'presentation/blocs/top_rated_tv_cubit.dart';
import 'presentation/blocs/tv_detail_cubit.dart';
import 'presentation/blocs/tv_list_cubit.dart';
import 'presentation/blocs/tv_search_cubit.dart';

class RegisterTvBloc extends StatelessWidget {
  const RegisterTvBloc({
    super.key,
    required this.locator,
    required this.child,
  });

  final GetIt locator;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<TvListCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<TvDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<TvSearchCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<OnTheAirTvCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<TopRatedTvCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<PopularTvCubit>(),
        ),
      ],
      child: child,
    );
  }
}

void loadTvInjection(GetIt locator) {
  /// Bloc TV
  locator.registerFactory(
    () => TvListCubit(
      getOnTheAirTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailCubit(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchCubit(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirTvCubit(
      getOnTheAirTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvCubit(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvCubit(
      getPopularTv: locator(),
    ),
  );

  /// Use Case TV
  locator.registerLazySingleton(() => GetOnTheAirTv(repo: locator()));
  locator.registerLazySingleton(() => GetPopularTv(repo: locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(repo: locator()));
  locator.registerLazySingleton(() => GetTvDetail(repo: locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(repo: locator()));
  locator.registerLazySingleton(() => SearchTv(repo: locator()));

  /// Repository
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  /// Data Sources
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
}
