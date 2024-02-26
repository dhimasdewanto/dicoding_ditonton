part of 'tv_search_cubit.dart';

class TvSearchState extends Equatable {
  final RequestState state;
  final List<Movie> searchResults;
  final String message;

  const TvSearchState({
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

  TvSearchState copyWith({
    RequestState? state,
    List<Movie>? searchResults,
    String? message,
  }) {
    return TvSearchState(
      state: state ?? this.state,
      searchResults: searchResults ?? this.searchResults,
      message: message ?? this.message,
    );
  }
}
