import 'package:flutter/material.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/tv/get_on_the_air_tv.dart';
import '../../../domain/usecases/tv/get_popular_tv.dart';
import '../../../domain/usecases/tv/get_top_rated_tv.dart';

class TvListNotifier extends ChangeNotifier {
  var _onTheAirShows = <Movie>[];
  List<Movie> get onTheAirShows => _onTheAirShows;

  RequestState _onTheAirState = RequestState.empty;
  RequestState get onTheAirState => _onTheAirState;

  var _popularShows = <Movie>[];
  List<Movie> get popularShows => _popularShows;

  RequestState _popularState = RequestState.empty;
  RequestState get popularState => _popularState;

  var _topRatedShows = <Movie>[];
  List<Movie> get topRatedShows => _topRatedShows;

  RequestState _topRatedState = RequestState.empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getOnTheAirTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  });

  final GetOnTheAirTv getOnTheAirTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchOnTheAir() async {
    _onTheAirState = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirTv();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _onTheAirState = RequestState.loaded;
        _onTheAirShows = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopular() async {
    _popularState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTv();
    result.fold(
      (failure) {
        _popularState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularState = RequestState.loaded;
        _popularShows = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRated() async {
    _topRatedState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTv();
    result.fold(
      (failure) {
        _topRatedState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedState = RequestState.loaded;
        _topRatedShows = moviesData;
        notifyListeners();
      },
    );
  }
}
