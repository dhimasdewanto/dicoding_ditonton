import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'common/constants.dart';
import 'common/utils.dart';
import 'injection.dart' as di;
import 'presentation/blocs/tv/on_the_air_tv_cubit.dart';
import 'presentation/blocs/tv/popular_tv_cubit.dart';
import 'presentation/blocs/tv/top_rated_tv_cubit.dart';
import 'presentation/blocs/tv/tv_detail_cubit.dart';
import 'presentation/blocs/tv/tv_list_cubit.dart';
import 'presentation/blocs/tv/tv_search_cubit.dart';
import 'presentation/pages/about_page.dart';
import 'presentation/pages/home_movie_page.dart';
import 'presentation/pages/home_tv_page.dart';
import 'presentation/pages/movie_detail_page.dart';
import 'presentation/pages/on_the_air_tv_page.dart';
import 'presentation/pages/popular_movies_page.dart';
import 'presentation/pages/popular_tv_page.dart';
import 'presentation/pages/search_page.dart';
import 'presentation/pages/search_tv_page.dart';
import 'presentation/pages/top_rated_movies_page.dart';
import 'presentation/pages/top_rated_tv_page.dart';
import 'presentation/pages/tv_detail_page.dart';
import 'presentation/pages/watchlist_movies_page.dart';
import 'presentation/provider/movie/movie_detail_notifier.dart';
import 'presentation/provider/movie/movie_list_notifier.dart';
import 'presentation/provider/movie/movie_search_notifier.dart';
import 'presentation/provider/movie/popular_movies_notifier.dart';
import 'presentation/provider/movie/top_rated_movies_notifier.dart';
import 'presentation/provider/watchlist/watchlist_movie_notifier.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// Movie
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),

        /// Watchlist
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
      ],
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
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case HomeMoviePage.routeName:
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
              case PopularMoviesPage.routeName:
                return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage(),
                );
              case PopularTvPage.routeName:
                return CupertinoPageRoute(
                  builder: (_) => const PopularTvPage(),
                );
              case TopRatedMoviesPage.routeName:
                return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage(),
                );
              case TopRatedTvPage.routeName:
                return CupertinoPageRoute(
                  builder: (_) => const TopRatedTvPage(),
                );
              case MovieDetailPage.routeName:
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
              case SearchPage.routeName:
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
