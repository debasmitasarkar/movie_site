import 'package:flutter/material.dart';
import 'package:movie_app_assignment/datasource/remote_api.dart';
import 'package:movie_app_assignment/models/movie_details_response.dart';
import 'package:movie_app_assignment/models/movie_list_response.dart';

class MovieNotifier extends ChangeNotifier {
  List<Movie>? movieList;
  int? selectedMovieId;
  MovieDetails? selectedMovieDetails;
  RemoteApi api = RemoteApi();

  Future<List<Movie>?> fetchMovieList() {
    return api.fetchMovies().then((list) {
      movieList = list;
      notifyListeners();
      return movieList;
    });
  }

  Future<MovieDetails?> fetchMovieDetails() {
    return api.fetchMovieDetails(selectedMovieId!).then((details) {
      selectedMovieDetails = details;
      notifyListeners();
      return selectedMovieDetails;
    });
  }
}
