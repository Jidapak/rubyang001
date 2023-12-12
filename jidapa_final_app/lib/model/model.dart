import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Movie {
  String id = "";
  late String genre;
  late String imagePath;
  late String length;
  late String source;
  late String title;
  Movie(
    this.genre,
    this.imagePath,
    this.length,
    this.source,
    this.title,
  ); 
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      json['genre'] as String,
      json['imagePath'] as String,
      json['length'] as String,
      json['source'] as String,
      json['title'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'genre': genre,
      'imagePath': imagePath,
      'length': length,
      'source': source,
      'title': title,
    };
  }
   @override
  String toString() {
    return 'Movie{title: $title, genre: $genre, length: $length, source: $source, imagePath: $imagePath}';
  }
}
class AllMovies {
  final List<Movie> movies;
  AllMovies(this.movies);
  factory AllMovies.fromJson(List<dynamic> json) {
    List<Movie> movies = json.map((item) => Movie.fromJson(item)).toList();
    return AllMovies(movies);
  }
  factory AllMovies.fromSnapshot(QuerySnapshot qs) {
    List<Movie> movies = qs.docs.map((DocumentSnapshot ds) {
      Movie movie = Movie.fromJson(ds.data() as Map<String, dynamic>);
      movie.id = ds.id;
      return movie;
    }).toList();
    return AllMovies(movies);
  }
}
class MovieProvider with ChangeNotifier {
  Movie? _ListMovie;
  Movie? get ListMovie => _ListMovie;
  void setListMovie(Movie movie) {
    _ListMovie = movie;
    notifyListeners();
  }
}
