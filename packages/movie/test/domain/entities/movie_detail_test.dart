import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

void main() {
  test('Should success convert to movie item', () {
    const item = Movie(
      adult: false,
      backdropPath: "123",
      genreIds: [1, 2, 3],
      id: 123,
      originalTitle: "123",
      overview: "123",
      popularity: 123.4,
      posterPath: "123",
      releaseDate: "123",
      title: "123",
      voteAverage: 123.45,
      voteCount: 12345,
    );
    const detail = MovieDetail(
      adult: false,
      backdropPath: "123",
      genres: [
        Genre(id: 1, name: "1"),
        Genre(id: 2, name: "2"),
        Genre(id: 3, name: "3"),
      ],
      id: 123,
      originalTitle: "123",
      overview: "123",
      posterPath: "123",
      releaseDate: "123",
      runtime: 123,
      title: "123",
      voteAverage: 123.45,
      voteCount: 12345,
      popularity: 123.4,
    );
    final detailToItem = detail.toMovie();
    expect(detailToItem, item);
  });
}
