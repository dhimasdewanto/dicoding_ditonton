import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common/exception.dart';
import '../models/tv_model.dart';
import '../models/tv_response.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getAiringToday();
  Future<List<TvModel>> getPopular();
  Future<List<TvModel>> getTopRated();
  Future<List<TvModel>> getRecommendations(int id);
  Future<List<TvModel>> search(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getAiringToday() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/airing_today?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopular() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRated() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> search(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
