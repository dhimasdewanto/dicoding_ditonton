// import 'package:dicoding_ditonton/data/models/movie_table.dart';
// import 'package:dicoding_ditonton/domain/entities/genre.dart';
// import 'package:dicoding_ditonton/domain/entities/movie.dart';
// import 'package:dicoding_ditonton/domain/entities/movie_detail.dart';
// import 'package:dicoding_ditonton/domain/entities/season.dart';
// import 'package:dicoding_ditonton/domain/enums/show_type.dart';

// const testMovie = Movie(
//   type: ShowType.movie,
//   adult: false,
//   backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
//   genreIds: [14, 28],
//   id: 557,
//   originalTitle: 'Spider-Man',
//   overview:
//       'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
//   popularity: 60.441,
//   posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
//   releaseDate: '2002-05-01',
//   title: 'Spider-Man',
//   voteAverage: 7.2,
//   voteCount: 13507,
// );

// const testMovie2 = Movie(
//   type: ShowType.movie,
//   adult: false,
//   backdropPath: 'backdropPath',
//   genreIds: [14, 28],
//   id: 1,
//   originalTitle: 'originalTitle',
//   overview: 'overview',
//   posterPath: 'posterPath',
//   releaseDate: 'releaseDate',
//   title: 'title',
//   voteAverage: 1,
//   voteCount: 1,
//   popularity: 60.441,
// );

// final testMovieList = [testMovie];

// const testMovieDetail = MovieDetail(
//   type: ShowType.movie,
//   adult: false,
//   backdropPath: 'backdropPath',
//   genres: [Genre(id: 1, name: 'Action')],
//   id: 1,
//   originalTitle: 'originalTitle',
//   overview: 'overview',
//   posterPath: 'posterPath',
//   releaseDate: 'releaseDate',
//   runtime: 120,
//   title: 'title',
//   voteAverage: 1,
//   voteCount: 1,
//   popularity: 100,
//   seasons: [],
// );

// const testTvDetail = MovieDetail(
//   type: ShowType.tv,
//   adult: false,
//   backdropPath: 'backdropPath',
//   genres: [Genre(id: 1, name: 'Action')],
//   id: 1,
//   originalTitle: 'originalTitle',
//   overview: 'overview',
//   posterPath: 'posterPath',
//   releaseDate: 'releaseDate',
//   runtime: 120,
//   title: 'title',
//   voteAverage: 1,
//   voteCount: 1,
//   popularity: 100,
//   seasons: [
//     Season(
//       airDate: null,
//       episodeCount: 5,
//       id: 123,
//       name: "Season",
//       overview: "",
//       posterPath: "",
//       seasonNumber: 5,
//       voteAverage: 5,
//     ),
//   ],
// );



import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/watchlist.dart';

const testTable = WatchlistTable(
  type: "movie",
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMap = {
  'id': 1,
  'type': 'movie',
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testItem = Watchlist(
  type: ShowType.movie,
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
);

const testList = [testItem];

// const testWatchlistMovie = Movie.watchlist(
//   type: ShowType.movie,
//   id: 1,
//   title: 'title',
//   posterPath: 'posterPath',
//   overview: 'overview',
// );