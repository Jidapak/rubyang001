import 'dart:async';
import 'package:jidapa_final_app/model/model.dart';
import 'package:jidapa_final_app/servicce/service.dart';

class MovieController {
  List<Movie> movies = List.empty();
  final MovieService service;
  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;
  MovieController(this.service);
  Future<List<Movie>> fetchMovies() async {
    print(
      "fetchMovies was: $movies"
      );
    onSyncController.add(true);
    movies = await service.fetchMovies();
    onSyncController.add(false);
    return movies;
  }
    void updateMovie(Movie movie) async {
    service.updateMovie(movie);
  }
}