import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/get_movie_detail.dart';
import 'domain/usecases/get_movie_recommendations.dart';
import 'domain/usecases/get_now_playing_movies.dart';
import 'domain/usecases/get_popular_movies.dart';
import 'domain/usecases/get_top_rated_movies.dart';
import 'domain/usecases/search_movies.dart';
import 'presentation/blocs/movie_detail_cubit.dart';
import 'presentation/blocs/movie_list_cubit.dart';
import 'presentation/blocs/movie_search_cubit.dart';
import 'presentation/blocs/popular_movies_cubit.dart';
import 'presentation/blocs/top_rated_movies_cubit.dart';

class RegisterMovieBloc extends StatelessWidget {
  const RegisterMovieBloc({
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
          create: (_) => locator<MovieListCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<MovieDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<MovieSearchCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<TopRatedMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<PopularMoviesCubit>(),
        ),
      ],
      child: child,
    );
  }
}

void loadMovieInjection(GetIt locator) {
  /// Bloc Movie
  locator.registerFactory(
    () => MovieListCubit(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailCubit(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      // getWatchListStatus: locator(),
      // saveWatchlist: locator(),
      // removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchCubit(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesCubit(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesCubit(
      getTopRatedMovies: locator(),
    ),
  );

  /// Use Case Movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));

  /// Repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  /// Data Sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
}
