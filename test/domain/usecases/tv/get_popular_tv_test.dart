import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/repositories/tv_repository.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/get_popular_tv.dart';

import '../../../helpers/test_helper.dart';

void main() {
  late GetPopularTv usecase;
  late TvRepository mockRepo;

  setUp(() {
    mockRepo = MockTvRepository();
    usecase = GetPopularTv(repo: mockRepo);
  });

  final tMovies = <Movie>[];

  test(
      'Should get list of popular tv shows from the repository',
      () async {
    // arrange
    when(() => mockRepo.getPopular()).thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase();
    // assert
    expect(result, Right(tMovies));
  });
}
