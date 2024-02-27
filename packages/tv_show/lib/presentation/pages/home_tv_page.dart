import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/tv_show.dart';
import '../blocs/tv_list_cubit.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({super.key});

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvListCubit>()
      ..fetchOnTheAir()
      ..fetchPopular()
      ..fetchTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: kPrussianBlue),
              currentAccountPicture: CircleAvatar(
                backgroundColor: kPrussianBlue,
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Shows'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.movie_outlined),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.movieHome,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, Routes.watchlist);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, Routes.about);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton TV Shows'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.tvSearch);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On The Air',
                onTap: () =>
                    Navigator.pushNamed(context, Routes.tvOnTheAir),
              ),
              BlocBuilder<TvListCubit, TvListState>(
                builder: (context, cubitState) {
                  final state = cubitState.stateOnTheAir;
                  if (state == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.loaded) {
                    return MovieList(shows: cubitState.showsOnTheAir);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, Routes.tvPopular),
              ),
              BlocBuilder<TvListCubit, TvListState>(
                builder: (context, cubitState) {
                  final state = cubitState.statePopular;
                  if (state == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.loaded) {
                    return MovieList(shows: cubitState.showsPopular);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, Routes.tvTopRated),
              ),
              BlocBuilder<TvListCubit, TvListState>(
                builder: (context, cubitState) {
                  final state = cubitState.stateTopRated;
                  if (state == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.loaded) {
                    return MovieList(shows: cubitState.showsTopRated);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
    required this.shows,
  });

  final List<TvShow> shows;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = shows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.tvDetail,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: shows.length,
      ),
    );
  }
}
