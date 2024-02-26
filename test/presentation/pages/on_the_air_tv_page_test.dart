// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// import 'package:dicoding_ditonton/common/state_enum.dart';
// import 'package:dicoding_ditonton/domain/entities/movie.dart';
// import 'package:dicoding_ditonton/presentation/pages/on_the_air_tv_page.dart';
// import 'package:dicoding_ditonton/presentation/provider/tv/on_the_air_tv_notifier.dart';

// import 'on_the_air_tv_page_test.mocks.dart';

// @GenerateMocks([OnTheAirTvNotifier])
// void main() {
//   late OnTheAirTvNotifier mockNotifier;

//   setUp(() {
//     mockNotifier = MockOnTheAirTvNotifier();
//   });

//   Widget makeTestableWidget(Widget body) {
//     return ChangeNotifierProvider<OnTheAirTvNotifier>.value(
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

//     await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

//     expect(centerFinder, findsOneWidget);
//     expect(progressFinder, findsOneWidget);
//   });

//   testWidgets('Page should display when data is loaded',
//       (WidgetTester tester) async {
//     when(mockNotifier.state).thenReturn(RequestState.loaded);
//     when(mockNotifier.movies).thenReturn(<Movie>[]);

//     final listViewFinder = find.byType(ListView);

//     await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

//     expect(listViewFinder, findsOneWidget);
//   });

//   testWidgets('Page should display text with message when Error',
//       (WidgetTester tester) async {
//     when(mockNotifier.state).thenReturn(RequestState.error);
//     when(mockNotifier.message).thenReturn('Error message');

//     final textFinder = find.byKey(const Key('error_message'));

//     await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

//     expect(textFinder, findsOneWidget);
//   });
// }
