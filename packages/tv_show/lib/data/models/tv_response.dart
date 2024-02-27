import 'package:equatable/equatable.dart';

import 'tv_model.dart';

class TvResponse extends Equatable {
  final List<TvModel> results;

  const TvResponse({required this.results});

  factory TvResponse.fromMap(Map<String, dynamic> json) => TvResponse(
        results: List<TvModel>.from((json["results"] as List)
            .map((x) => TvModel.fromMap(x))
            .where((element) => element.posterPath != null)),
      );

  @override
  List<Object> get props => [results];

  Map<String, dynamic> toMap() {
    return {
      'results': results.map((x) => x.toMap()).toList(),
    };
  }
}
