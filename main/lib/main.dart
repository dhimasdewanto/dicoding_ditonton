import 'package:core/core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:tv_show/tv_show.dart';
import 'package:watchlist/injection.dart';
import 'package:watchlist/watchlist.dart';

import 'firebase_options.dart';
import 'injection.dart' as di;
import 'presentation/pages/about_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  final httpSslClient = await getSSLPinningClient();
  di.init(
    httpClient: httpSslClient,
  );

  /// Pass all uncaught "fatal" errors from the framework to Crashlytics.
  ///
  /// NOTE: For some reason, using non fatal option (recordFlutterError) won't send
  /// error to crashlytics.
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterTvBloc(
      locator: di.locator,
      child: RegisterMovieBloc(
        locator: di.locator,
        child: RegisterWatchlistBloc(
        locator: di.locator,
          child: MaterialApp(
            title: 'Ditonton',
            theme: ThemeData.dark().copyWith(
              colorScheme: kColorScheme,
              primaryColor: kRichBlack,
              scaffoldBackgroundColor: kRichBlack,
              textTheme: kTextTheme,
            ),
            home: const HomeTvPage(),
            navigatorObservers: [
              routeObserver,
              FirebaseAnalyticsObserver(
                analytics: FirebaseAnalytics.instance,
              ),
            ],
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case Routes.movieHome:
                  return MaterialPageRoute(
                    builder: (_) => const HomeMoviePage(),
                  );
                case Routes.tvHome:
                  return MaterialPageRoute(
                    builder: (_) => const HomeTvPage(),
                  );
                case Routes.tvOnTheAir:
                  return CupertinoPageRoute(
                    builder: (_) => const OnTheAirTvPage(),
                  );
                case Routes.moviePopular:
                  return CupertinoPageRoute(
                    builder: (_) => const PopularMoviesPage(),
                  );
                case Routes.tvPopular:
                  return CupertinoPageRoute(
                    builder: (_) => const PopularTvPage(),
                  );
                case Routes.movieTopRated:
                  return CupertinoPageRoute(
                    builder: (_) => const TopRatedMoviesPage(),
                  );
                case Routes.tvTopRated:
                  return CupertinoPageRoute(
                    builder: (_) => const TopRatedTvPage(),
                  );
                case Routes.movieDetail:
                  final id = settings.arguments as int;
                  return MaterialPageRoute(
                    builder: (_) => MovieDetailPage(id: id),
                    settings: settings,
                  );
                case Routes.tvDetail:
                  final id = settings.arguments as int;
                  return MaterialPageRoute(
                    builder: (_) => TvDetailPage(id: id),
                    settings: settings,
                  );
                case Routes.movieSearch:
                  return CupertinoPageRoute(
                    builder: (_) => const SearchPage(),
                  );
                case Routes.tvSearch:
                  return CupertinoPageRoute(
                    builder: (_) => const SearchTvPage(),
                  );
                case Routes.watchlist:
                  return MaterialPageRoute(
                    builder: (_) => const WatchlistListPage(),
                  );
                case Routes.about:
                  return MaterialPageRoute(
                    builder: (_) => const AboutPage(),
                  );
                default:
                  return MaterialPageRoute(
                    builder: (_) {
                      return const Scaffold(
                        body: Center(
                          child: Text('Page not found :('),
                        ),
                      );
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
