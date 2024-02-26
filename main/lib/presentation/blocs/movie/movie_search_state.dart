part of 'movie_search_cubit.dart';

class MovieSearchState extends Equatable {
  final RequestState state;
  final List<Movie> searchResults;
  final String message;

  const MovieSearchState({
    this.state = RequestState.empty,
    this.searchResults = const [],
    this.message = "",
  });

  @override
  List<Object?> get props => [
        state,
        searchResults,
        message,
      ];

  MovieSearchState copyWith({
    RequestState? state,
    List<Movie>? searchResults,
    String? message,
  }) {
    return MovieSearchState(
      state: state ?? this.state,
      searchResults: searchResults ?? this.searchResults,
      message: message ?? this.message,
    );
  }
}
