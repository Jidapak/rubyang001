import 'package:flutter/material.dart';
import 'package:jidapa_final_app/bookingpage.dart';
import 'package:jidapa_final_app/model/model.dart';
import 'package:jidapa_final_app/servicce/service.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}
class _MoviesListPageState extends State<ListPage> {
  late Future<List<Movie>> moviesFuture;
  @override
  void initState() {
    super.initState();
    moviesFuture = Movies_Service().fetchMovies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (
            snapshot.connectionState == ConnectionState.waiting
            ) {
            return Center(
              child: CircularProgressIndicator()
              );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(' ${snapshot.error}')
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
              print(snapshot.data);
                Movie movie = snapshot.data![index];
                return MovieItem(movie: movie);
              },
            );
          }
        },
      ),
    );
  }
}
class MovieItem extends StatelessWidget {
  final Movie movie;
  const MovieItem({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<MovieProvider>(context, listen: false)
            .setListMovie(movie);
            Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingApp(),
          ),
        );
      },
      child: Container(
        width: double.infinity, 
        margin: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Image.network(
              movie.imagePath,
              width: 120.0, 
              height: 160.0, 
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Title: ${movie.title}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                        ),
                    ),
                    Text('Genre: ${movie.genre}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        ),
                    ),
                    Text('Length: ${movie.length}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        ),
                    ),
                    Text('Source: ${movie.source}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
