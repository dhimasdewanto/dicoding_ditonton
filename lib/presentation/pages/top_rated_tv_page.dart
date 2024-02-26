import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/state_enum.dart';
import '../../presentation/widgets/movie_card_list.dart';
import '../blocs/tv/top_rated_tv_cubit.dart';

class TopRatedTvPage extends StatefulWidget {
  static const routeName = '/top-rated-tv';

  const TopRatedTvPage({super.key});

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TopRatedTvCubit>().fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvCubit, TopRatedTvState>(
          builder: (context, data) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return MovieCard(movie);
                },
                itemCount: data.movies.length,
              );
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
