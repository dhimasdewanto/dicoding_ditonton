import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movie_local_data_source.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/datasources/tv_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'data/repositories/tv_repository_impl.dart';
import 'data/repositories/watchlist_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/repositories/tv_repository.dart';
import 'domain/repositories/watchlist_repository.dart';
import 'domain/usecases/movie/get_movie_detail.dart' as movie;
import 'domain/usecases/movie/get_movie_recommendations.dart' as movie;
import 'domain/usecases/movie/get_now_playing_movies.dart' as movie;
import 'domain/usecases/movie/get_popular_movies.dart' as movie;
import 'domain/usecases/movie/get_top_rated_movies.dart' as movie;
import 'domain/usecases/movie/get_watchlist_movies.dart' as movie;
import 'domain/usecases/movie/get_watchlist_status.dart' as movie;
import 'domain/usecases/movie/remove_watchlist.dart' as movie;
import 'domain/usecases/movie/save_watchlist.dart' as movie;
import 'domain/usecases/movie/search_movies.dart' as movie;
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
import 'presentation/provider/movie/movie_detail_notifier.dart';
import 'presentation/provider/movie/movie_list_notifier.dart';
import 'presentation/provider/movie/movie_search_notifier.dart';
import 'presentation/provider/movie/popular_movies_notifier.dart';
import 'presentation/provider/movie/top_rated_movies_notifier.dart';
import 'presentation/provider/tv/on_the_air_tv_notifier.dart';
import 'presentation/provider/tv/popular_tv_notifier.dart';
import 'presentation/provider/tv/top_rated_tv_notifier.dart';
import 'presentation/provider/tv/tv_detail_notifier.dart';
import 'presentation/provider/tv/tv_list_notifier.dart';
import 'presentation/provider/tv/tv_search_notifier.dart';
import 'presentation/provider/watchlist/watchlist_movie_notifier.dart';

final locator = GetIt.instance;

void init() {
  /// Provider Movie
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );

  /// Provider TV
  locator.registerFactory(
    () => TvListNotifier(
      getOnTheAirTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirTvNotifier(
      getOnTheAirTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvNotifier(
      getPopularTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedTv: locator(),
    ),
  );

  /// Provider Watchlist
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  /// Use Case Movie
  locator.registerLazySingleton(() => movie.GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => movie.GetPopularMovies(locator()));
  locator.registerLazySingleton(() => movie.GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => movie.GetMovieDetail(locator()));
  locator.registerLazySingleton(() => movie.GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => movie.SearchMovies(locator()));
  locator.registerLazySingleton(() => movie.GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => movie.SaveWatchlist(locator()));
  locator.registerLazySingleton(() => movie.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => movie.GetWatchlistMovies(locator()));

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
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
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
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  /// Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  /// External
  locator.registerLazySingleton(() => http.Client());
}
