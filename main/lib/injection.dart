import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie/movie.dart';
import 'package:tv_show/tv_show.dart';
import 'package:watchlist/injection.dart';

final locator = GetIt.instance;

void init({
  required http.Client httpClient,
}) {
  loadTvInjection(locator);
  loadMovieInjection(locator);
  loadWatchlistInjection(locator);

  /// External
  locator.registerLazySingleton<http.Client>(() => httpClient);
}
