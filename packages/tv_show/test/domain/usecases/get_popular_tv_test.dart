import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/repositories/tv_repository.dart';
import 'package:tv_show/domain/usecases/get_popular_tv.dart';

import '../../helpers/test_helper.dart';

void main() {
  late GetPopularTv usecase;
  late TvRepository mockRepo;

  setUp(() {
    mockRepo = MockTvRepository();
    usecase = GetPopularTv(repo: mockRepo);
  });

  final tMovies = <TvShow>[];

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
