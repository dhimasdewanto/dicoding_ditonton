import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/repositories/tv_repository.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/get_tv_recommendations.dart';

import '../../../helpers/test_helper.dart';

void main() {
  late GetTvRecommendations usecase;
  late TvRepository mockRepo;

  setUp(() {
    mockRepo = MockTvRepository();
    usecase = GetTvRecommendations(repo: mockRepo);
  });

  const tId = 1;
  final tMovies = <Movie>[];

  test(
      'Should get list of recommended tv shows from the repository based on id',
      () async {
    // arrange
    when(() => mockRepo.getRecommendations(tId))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase(tId);
    // assert
    expect(result, Right(tMovies));
  });
}
