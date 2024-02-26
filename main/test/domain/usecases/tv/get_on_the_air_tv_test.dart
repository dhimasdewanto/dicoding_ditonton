import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/repositories/tv_repository.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/get_on_the_air_tv.dart';

import '../../../helpers/test_helper.dart';

void main() {
  late GetOnTheAirTv usecase;
  late TvRepository mockRepo;

  setUp(() {
    mockRepo = MockTvRepository();
    usecase = GetOnTheAirTv(repo: mockRepo);
  });

  final tMovies = <Movie>[];

  test('Should get list of on the air tv shows from the repository', () async {
    // arrange
    when(() => mockRepo.getOnTheAir()).thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase();
    // assert
    expect(result, Right(tMovies));
  });
}
