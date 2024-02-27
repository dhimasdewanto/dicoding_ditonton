import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/repositories/tv_repository.dart';
import 'package:tv_show/domain/usecases/search_tv.dart';

import '../../helpers/test_helper.dart';

void main() {
  late SearchTv usecase;
  late TvRepository mockRepo;

  setUp(() {
    mockRepo = MockTvRepository();
    usecase = SearchTv(repo: mockRepo);
  });

  final tMovies = <TvShow>[];
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
