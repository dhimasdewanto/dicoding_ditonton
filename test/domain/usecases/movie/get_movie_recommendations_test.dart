import 'package:dicoding_ditonton/domain/repositories/movie_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_helper.dart';

void main() {
  late GetMovieRecommendations usecase;
  late MovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieRecommendations(mockMovieRepository);
  });

  const tId = 1;
  final tMovies = <Movie>[];

  test('should get list of movie recommendations from the repository',
      () async {
    // arrange
    when(() => mockMovieRepository.getMovieRecommendations(tId))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase(tId);
    // assert
    expect(result, Right(tMovies));
  });
}
