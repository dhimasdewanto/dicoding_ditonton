import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/tv_card.dart';
import '../blocs/on_the_air_tv_cubit.dart';

class OnTheAirTvPage extends StatefulWidget {
  const OnTheAirTvPage({super.key});

  @override
  State<OnTheAirTvPage> createState() => _OnTheAirTvPageState();
}

class _OnTheAirTvPageState extends State<OnTheAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () =>  context.read<OnTheAirTvCubit>().fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvCubit, OnTheAirTvState>(
          builder: (context, data) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.shows[index];
                  return TvCard(tvShow: tvShow);
                },
                itemCount: data.shows.length,
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
