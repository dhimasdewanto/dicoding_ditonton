part of 'watchlist_list_cubit.dart';

class WatchlistState extends Equatable {
  final RequestState state;
  final List<Watchlist> movies;
  final String message;

  const WatchlistState({
    this.state = RequestState.empty,
    this.movies = const [],
    this.message = "",
  });

  @override
  List<Object?> get props => [
        state,
        movies,
        message,
      ];

  WatchlistState copyWith({
    RequestState? state,
    List<Watchlist>? movies,
    String? message,
  }) {
    return WatchlistState(
      state: state ?? this.state,
      movies: movies ?? this.movies,
      message: message ?? this.message,
    );
  }
}
