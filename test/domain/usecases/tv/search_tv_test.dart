import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/repositories/tv_repository.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/search_tv.dart';

import '../../../helpers/test_helper.dart';

void main() {
  late SearchTv usecase;
  late TvRepository mockRepo;

  setUp(() {
    mockRepo = MockTvRepository();
    usecase = SearchTv(repo: mockRepo);
  });

  final tMovies = <Movie>[];
  const tQuery = 'Spiderman';

  test('Should get list of tv shows from the repository based on search query',
      () async {
    // arrange
    when(() => mockRepo.search(tQuery)).thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase(tQuery);
    // assert
    expect(result, Right(tMovies));
  });
}
