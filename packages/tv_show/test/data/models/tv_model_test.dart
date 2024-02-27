import 'package:flutter_test/flutter_test.dart';
import 'package:tv_show/data/models/tv_model.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

void main() {
  const tModel = TvModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  const tItem = TvShow(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  test('Should be a subclass of entity', () async {
    final result = tModel.toEntity();
    expect(result, tItem);
  });
}
