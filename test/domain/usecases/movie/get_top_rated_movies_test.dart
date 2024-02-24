import 'package:dicoding_ditonton/domain/repositories/movie_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_helper.dart';

void main() {
  late GetTopRatedMovies usecase;
  late MovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockV2MovieRepository();
    usecase = GetTopRatedMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];

  test('should get list of movies from repository', () async {
    // arrange
    when(() => mockMovieRepository.getTopRatedMovies())
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase();
    // assert
    expect(result, Right(tMovies));
  });
}
