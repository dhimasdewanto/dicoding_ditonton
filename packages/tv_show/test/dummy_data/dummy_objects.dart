import 'package:tv_show/domain/entities/genre.dart';
import 'package:tv_show/domain/entities/season.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/entities/tv_show_detail.dart';

const testItem = TvShow(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  voteAverage: 7.2,
  voteCount: 13507,
);

final testList = [testItem];

const testDetail = TvShowDetail(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genres: [
    Genre(id: 14, name: 'Action'),
    Genre(id: 28, name: 'Horror'),
  ],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  runtime: 120,
  title: 'Spider-Man',
  popularity: 100,
  voteAverage: 7.2,
  voteCount: 13507,
  seasons: [
    Season(
      airDate: null,
      episodeCount: 5,
      id: 123,
      name: "Season",
      overview: "",
      posterPath: "",
      seasonNumber: 5,
      voteAverage: 5,
    ),
  ],
);