import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/watchlist_local_data_source.dart';
import 'data/repositories/watchlist_repository_impl.dart';
import 'domain/repositories/watchlist_repository.dart';
import 'presentation/blocs/watchlist_list_cubit.dart';
import 'watchlist.dart';

class RegisterWatchlistBloc extends StatelessWidget {
  const RegisterWatchlistBloc({
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
          create: (_) => locator<WatchlistCubit>(),
        ),
      ],
      child: child,
    );
  }
}

void loadWatchlistInjection(GetIt locator) {
  /// Bloc Watchlist
  locator.registerFactory(
    () => WatchlistCubit(
      getWatchlistItems: locator(),
    ),
  );

  /// Use Case Watchlist
  locator.registerLazySingleton(() => GetWatchListStatus(repo: locator()));
  locator.registerLazySingleton(() => SaveWatchlist(repo: locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(repo: locator()));
  locator.registerLazySingleton(() => GetWatchlistItems(repo: locator()));

  /// Repository
  locator.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(
      localDataSource: locator(),
    ),
  );

  /// Data Sources
  locator.registerLazySingleton<WatchlistLocalDataSource>(
      () => WatchlistLocalDataSourceImpl(databaseHelper: locator()));

  /// Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
