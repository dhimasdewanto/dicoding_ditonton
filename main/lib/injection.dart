import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie/movie.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movie_local_data_source.dart';
import 'data/datasources/tv_remote_data_source.dart';
import 'data/repositories/tv_repository_impl.dart';
import 'data/repositories/watchlist_repository_impl.dart';
import 'domain/repositories/tv_repository.dart';
import 'domain/repositories/watchlist_repository.dart';
import 'domain/usecases/tv/get_on_the_air_tv.dart';
import 'domain/usecases/tv/get_popular_tv.dart';
import 'domain/usecases/tv/get_top_rated_tv.dart';
import 'domain/usecases/tv/get_tv_detail.dart';
import 'domain/usecases/tv/get_tv_recommendations.dart';
import 'domain/usecases/tv/search_tv.dart';
import 'domain/usecases/watchlist/get_watchlist.dart';
import 'domain/usecases/watchlist/get_watchlist_status.dart';
import 'domain/usecases/watchlist/remove_watchlist.dart';
import 'domain/usecases/watchlist/save_watchlist.dart';
import 'presentation/blocs/tv/on_the_air_tv_cubit.dart';
import 'presentation/blocs/tv/popular_tv_cubit.dart';
import 'presentation/blocs/tv/top_rated_tv_cubit.dart';
import 'presentation/blocs/tv/tv_detail_cubit.dart';
import 'presentation/blocs/tv/tv_list_cubit.dart';
import 'presentation/blocs/tv/tv_search_cubit.dart';
import 'presentation/blocs/watchlist/watchlist_movie_cubit.dart';

final locator = GetIt.instance;

void init({
  required http.Client httpClient,
}) {
  loadMovieInjection(locator);

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
    () => PopularTvCubit(
      getPopularTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvCubit(
      getTopRatedTv: locator(),
    ),
  );

  /// Bloc Watchlist
  locator.registerFactory(
    () => WatchlistMovieCubit(
      getWatchlistMovies: locator(),
    ),
  );

  /// Use Case TV
  locator.registerLazySingleton(() => GetOnTheAirTv(repo: locator()));
  locator.registerLazySingleton(() => GetPopularTv(repo: locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(repo: locator()));
  locator.registerLazySingleton(() => GetTvDetail(repo: locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(repo: locator()));
  locator.registerLazySingleton(() => SearchTv(repo: locator()));

  /// Use Case Watchlist
  locator.registerLazySingleton(() => GetWatchListStatus(repo: locator()));
  locator.registerLazySingleton(() => SaveWatchlist(repo: locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(repo: locator()));
  locator.registerLazySingleton(() => GetWatchlist(repo: locator()));

  /// Repository
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(
      localDataSource: locator(),
    ),
  );

  /// Data Sources
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  /// Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  /// External
  locator.registerLazySingleton<http.Client>(() => httpClient);
}
