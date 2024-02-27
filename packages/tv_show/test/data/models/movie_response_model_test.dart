import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_show/data/models/tv_model.dart';
import 'package:tv_show/data/models/tv_response.dart';

import '../../helpers/json_reader.dart';

void main() {
  const tModel = TvModel(
    adult: false,
    backdropPath: '/xl1wGwaPZInJo1JAnpKqnFozWBE.jpg',
    genreIds: [35, 10767],
    id: 59941,
    originalName: 'The Tonight Show Starring Jimmy Fallon',
    overview:
        "After Jay Leno's second retirement from the program, Jimmy Fallon stepped in as his permanent replacement. After 42 years in Los Angeles the program was brought back to New York.",
    popularity: 3999.717,
    posterPath: '/g4amxJvtpnY79J77xeamnAEUO8r.jpg',
    releaseDate: null,
    name: 'The Tonight Show Starring Jimmy Fallon',
    voteAverage: 5.864,
    voteCount: 287,
  );
  const tResponse = TvResponse(
    results: <TvModel>[tModel],
  );

  group('fromMap', () {
    test('Should return a valid model from JSON map', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_popular.json'));
      // act
      final result = TvResponse.fromMap(jsonMap);
      // assert
      expect(result, tResponse);
    });
  });

  group('toMap', () {
    test('Should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tResponse.toMap();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdropPath": "/xl1wGwaPZInJo1JAnpKqnFozWBE.jpg",
            "genreIds": [35, 10767],
            "id": 59941,
            "originalName": "The Tonight Show Starring Jimmy Fallon",
            "overview":
                "After Jay Leno's second retirement from the program, Jimmy Fallon stepped in as his permanent replacement. After 42 years in Los Angeles the program was brought back to New York.",
            "popularity": 3999.717,
            "posterPath": "/g4amxJvtpnY79J77xeamnAEUO8r.jpg",
            "releaseDate": null,
            "name": "The Tonight Show Starring Jimmy Fallon",
            "voteAverage": 5.864,
            "voteCount": 287
          },
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
