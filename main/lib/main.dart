import 'package:core/core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

import 'firebase_options.dart';
import 'injection.dart' as di;
import 'presentation/blocs/tv/on_the_air_tv_cubit.dart';
import 'presentation/blocs/tv/popular_tv_cubit.dart';
import 'presentation/blocs/tv/top_rated_tv_cubit.dart';
import 'presentation/blocs/tv/tv_detail_cubit.dart';
import 'presentation/blocs/tv/tv_list_cubit.dart';
import 'presentation/blocs/tv/tv_search_cubit.dart';
import 'presentation/blocs/watchlist/watchlist_movie_cubit.dart';
import 'presentation/pages/about_page.dart';
import 'presentation/pages/home_tv_page.dart';
import 'presentation/pages/on_the_air_tv_page.dart';
import 'presentation/pages/popular_tv_page.dart';
import 'presentation/pages/search_tv_page.dart';
import 'presentation/pages/top_rated_tv_page.dart';
import 'presentation/pages/tv_detail_page.dart';
import 'presentation/pages/watchlist_movies_page.dart';

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
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterMovieBloc(
      locator: di.locator,
      child: MultiBlocProvider(
        providers: [
          /// TV
          BlocProvider(
            create: (_) => di.locator<TvListCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TvDetailCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TvSearchCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<OnTheAirTvCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TopRatedTvCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PopularTvCubit>(),
          ),
      
          /// Watchlist
          BlocProvider(
            create: (_) => di.locator<WatchlistMovieCubit>(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
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
              case HomeTvPage.routeName:
                return MaterialPageRoute(
                  builder: (_) => const HomeTvPage(),
                );
              case OnTheAirTvPage.routeName:
                return CupertinoPageRoute(
                  builder: (_) => const OnTheAirTvPage(),
                );
              case Routes.moviePopular:
                return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage(),
                );
              case PopularTvPage.routeName:
                return CupertinoPageRoute(
                  builder: (_) => const PopularTvPage(),
                );
              case Routes.movieTopRated:
                return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage(),
                );
              case TopRatedTvPage.routeName:
                return CupertinoPageRoute(
                  builder: (_) => const TopRatedTvPage(),
                );
              case Routes.movieDetail:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id),
                  settings: settings,
                );
              case TvDetailPage.routeName:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => TvDetailPage(id: id),
                  settings: settings,
                );
              case Routes.movieSearch:
                return CupertinoPageRoute(
                  builder: (_) => const SearchPage(),
                );
              case SearchTvPage.routeName:
                return CupertinoPageRoute(
                  builder: (_) => const SearchTvPage(),
                );
              case WatchlistMoviesPage.routeName:
                return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage(),
                );
              case AboutPage.routeName:
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
    );
  }
}
