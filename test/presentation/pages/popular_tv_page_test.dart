// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// import 'package:dicoding_ditonton/common/state_enum.dart';
// import 'package:dicoding_ditonton/domain/entities/movie.dart';
// import 'package:dicoding_ditonton/presentation/pages/popular_tv_page.dart';
// import 'package:dicoding_ditonton/presentation/provider/tv/popular_tv_notifier.dart';

// import 'popular_tv_page_test.mocks.dart';

// @GenerateMocks([PopularTvNotifier])
// void main() {
//   late PopularTvNotifier mockNotifier;

//   setUp(() {
//     mockNotifier = MockPopularTvNotifier();
//   });

//   Widget makeTestableWidget(Widget body) {
//     return ChangeNotifierProvider<PopularTvNotifier>.value(
//       value: mockNotifier,
//       child: MaterialApp(
//         home: body,
//       ),
//     );
//   }

//   testWidgets('Page should display progress bar when loading',
//       (WidgetTester tester) async {
//     when(mockNotifier.state).thenReturn(RequestState.loading);

//     final progressFinder = find.byType(CircularProgressIndicator);
//     final centerFinder = find.byType(Center);

//     await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

//     expect(centerFinder, findsOneWidget);
//     expect(progressFinder, findsOneWidget);
//   });

//   testWidgets('Page should display when data is loaded',
//       (WidgetTester tester) async {
//     when(mockNotifier.state).thenReturn(RequestState.loaded);
//     when(mockNotifier.movies).thenReturn(<Movie>[]);

//     final listViewFinder = find.byType(ListView);

//     await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

//     expect(listViewFinder, findsOneWidget);
//   });

//   testWidgets('Page should display text with message when Error',
//       (WidgetTester tester) async {
//     when(mockNotifier.state).thenReturn(RequestState.error);
//     when(mockNotifier.message).thenReturn('Error message');

//     final textFinder = find.byKey(const Key('error_message'));

//     await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

//     expect(textFinder, findsOneWidget);
//   });
// }
