import 'package:http/http.dart';
import 'package:movie_app_assignment/models/movie_details_response.dart';
import 'package:movie_app_assignment/models/movie_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_assignment/utils/config.dart';

class RemoteApi {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';

  Future<List<Movie>> fetchMovies() async {
    try {
      Response response = await http
          .get(Uri.parse('$baseUrl/movie/popular?api_key=${Config.apiKey}'));
      MovieListResponse movieListResponse =
          movieListResponseFromJson(response.body);
      return movieListResponse.results;
    } catch (e) {
      throw e;
    }
  }

  Future<MovieDetails> fetchMovieDetails(int movieId) async {
    try {
      Response response = await http
          .get(Uri.parse('$baseUrl/movie/$movieId?api_key=${Config.apiKey}'));
      MovieDetails movieDetails = movieDetailsFromJson(response.body);
      return movieDetails;
    } catch (e) {
      throw e;
    }
  }
}
