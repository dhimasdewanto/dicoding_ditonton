import 'package:dicoding_ditonton/domain/repositories/movie_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dicoding_ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late GetMovieDetail usecase;
  late MovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieDetail(mockMovieRepository);
  });

  const tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(() => mockMovieRepository.getMovieDetail(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    // act
    final result = await usecase(tId);
    // assert
    expect(result, const Right(testMovieDetail));
  });
}
