import 'package:dicoding_ditonton/domain/repositories/movie_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/usecases/movie/search_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_helper.dart';

void main() {
  late SearchMovies usecase;
  late MovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockV2MovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];
  const tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(() => mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase(tQuery);
    // assert
    expect(result, Right(tMovies));
  });
}
