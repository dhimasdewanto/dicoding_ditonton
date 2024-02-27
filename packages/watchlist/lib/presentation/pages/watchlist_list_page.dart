import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/watchlist_card.dart';
import '../blocs/watchlist_list_cubit.dart';

class WatchlistListPage extends StatefulWidget {
  const WatchlistListPage({super.key});

  @override
  State<WatchlistListPage> createState() => _WatchlistListPageState();
}

class _WatchlistListPageState extends State<WatchlistListPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WatchlistCubit>().fetch());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistCubit>()
        .fetch();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, data) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              if (data.movies.isEmpty) {
                return const Center(
                  child: Text("Watchlist is Empty"),
                );
              } else {
                return ListView.builder(
                  itemCount: data.movies.length,
                  itemBuilder: (context, index) {
                    final movie = data.movies[index];
                    return WatchlistCard(watchlist: movie);
                  },
                );
              }
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
