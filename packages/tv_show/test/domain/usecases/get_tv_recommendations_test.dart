import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/repositories/tv_repository.dart';
import 'package:tv_show/domain/usecases/get_tv_recommendations.dart';

import '../../helpers/test_helper.dart';

void main() {
  late GetTvRecommendations usecase;
  late TvRepository mockRepo;

  setUp(() {
    mockRepo = MockTvRepository();
    usecase = GetTvRecommendations(repo: mockRepo);
  });

  const tId = 1;
  final tMovies = <TvShow>[];

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
