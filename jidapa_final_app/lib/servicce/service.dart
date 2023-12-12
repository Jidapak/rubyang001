import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jidapa_final_app/model/model.dart';

abstract class MovieService {
  Future<List<Movie>> fetchMovies();
  void updateMovie(Movie movie);
}
class Movies_Service implements MovieService {
  @override
  Future<List<Movie>> fetchMovies() async {
    print("fetchMovies is called");
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('jidapa_movies')
        .get(); 
    print("Movie: ${qs.docs.length}");
    AllMovies movies = AllMovies.fromSnapshot(qs);
    print(movies.movies);
    return movies.movies;
  }
  @override
  void updateMovie(Movie movie) async {
    try {
      await FirebaseFirestore.instance
          .collection('jidapa_movies') 
          .doc(movie.id)
          .set(movie.toMap());
      print('Movie updated successfully');
    } catch (e) {
      print("Error updating movie: $e");
    }
  }
}
