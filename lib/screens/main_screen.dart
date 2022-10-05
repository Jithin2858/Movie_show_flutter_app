import 'dart:convert';
import 'package:task4/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task4/widgets/movie_item.dart';
import '../models/movie.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Movie> _movies = [];
  List<Imagee> _image = [];
  int _page = 1;
  @override
  void initState(){
    super.initState();
    populateMovies(_page);
  }

  Future<List<Movie>> _fetchMovies(int page) async{
    final response = await http.get(Uri.parse('https://www.episodate.com/api/most-popular?page=$page'));
    //final response = await http.get(Uri.parse('https://api.tvmaze.com/shows'));
    if(response.statusCode==200){
      final result = jsonDecode(response.body);
      //var data = result['tv_shows'];
      Iterable list= result['tv_shows'];
      //print('=====>$list');
      return list.map((e) => Movie.fromJson(e)).toList();
    }else{
      throw Exception('failed');
    }
  }

void populateMovies(int page) async {
    final myMovies = await _fetchMovies(page);
    setState(() {
      _movies.addAll(myMovies);
    });
    _page+=1;

    print('populating'+page.toString());
}
  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange){
        setState(() {
          populateMovies(_page);
        });
      }
    });
    return Scaffold(
      appBar:AppBar(
        title: Text('Task 4'),
      ),
      body: _movies.isEmpty?const Center(child: CircularProgressIndicator(),)
          : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3/4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 30
          ),
        itemBuilder: (ctx,i)=> MovieItem(
            _movies[i].id,
            _movies[i].image_thumbnail_path,
            _movies[i].name,
        ),
        itemCount: _movies.length,
        padding: EdgeInsets.all(10),
        controller: _controller,
      )
    );
  }
}
