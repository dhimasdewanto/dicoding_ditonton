import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_show/domain/repositories/tv_repository.dart';
import 'package:tv_show/domain/usecases/get_tv_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late GetTvDetail usecase;
  late TvRepository mockRepo;

  setUp(() {
    mockRepo = MockTvRepository();
    usecase = GetTvDetail(repo: mockRepo);
  });

  const tId = 1;

  test('Should get detail of tv show from the repository', () async {
    // arrange
    when(() => mockRepo.getDetail(tId))
        .thenAnswer((_) async => const Right(testDetail));
    // act
    final result = await usecase(tId);
    // assert
    expect(result, const Right(testDetail));
  });
}
