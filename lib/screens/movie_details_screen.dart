import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';

class MovieDetailScreen extends StatelessWidget {

  static const routeName = 'movie_details_screen';

  var _id;
  var _title;
  var _description;
  var _start;
  var _status;
  var _imageUrl;
  var _rating;
  var _genres;
  var _htmlDescription;

  Future _fetchDetails(String id) async{
    final response = await http.get(Uri.parse('https://www.episodate.com/api/show-details?q=$id'));
    //final response = await http.get(Uri.parse('https://api.tvmaze.com/shows'));
    if (response.statusCode==200){
      final result = jsonDecode(response.body);
      print('===>$result');
      final list =  result['tvShow'];
      _htmlDescription = list['description'];
      final document = parse(_htmlDescription);
      _description = parse(document.body!.text).documentElement!.text;
      _id = list['id'];
      _title = list['name'];
      _start = list['start_date'];
      _status = list['status'];
      _imageUrl = list['image_thumbnail_path'];
      _rating = list['rating'];
      _genres = list['genres'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final _movieId = ModalRoute.of(context)!.settings.arguments.toString();
    return FutureBuilder(
        future: _fetchDetails(_movieId),
        builder: (context,data){
          while(_id==null){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }return Scaffold(
            appBar: AppBar(
              title: Text(_title),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(padding: const EdgeInsets.only(left: 10,top: 10),
                      width: 200,
                      child: Image.network(_imageUrl,
                      fit: BoxFit.contain,
                          errorBuilder: (context,error,stackTrace){
                            return Container(
                              color: Colors.white,
                              child: LayoutBuilder(builder: (context,constraint){
                                return Icon(
                                  Icons.error_outline_sharp,
                                  color: Colors.red,
                                  size: constraint.biggest.width,
                                );
                              },),
                            );
                          }),
                      ),
                      const SizedBox(width: 50,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          CircleAvatar(backgroundColor: const Color(0xFFFFC400),
                              child: Text(double.parse(_rating.toString()).toStringAsFixed(1),
                              style: const TextStyle(fontWeight: FontWeight.bold),)),
                          const SizedBox(height: 20,),
                          const Text(
                            'Genres; ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 20,),
                          for ( var i in _genres)
                            Column(
                              children: [
                                Text(i.toString()),
                                const SizedBox(height: 10,)
                              ],
                            ),
                          const SizedBox(height: 20,),
                          const Text('Release Date ',style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                          ),
                          const SizedBox(height: 10,),
                          Text(_start.toString()),
                          const SizedBox(height: 10,),
                          Text(_status.toString()),
                          const SizedBox(height: 20,)
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      _description,
                      style: const TextStyle(fontSize: 18,height: 1.5,wordSpacing: 1.5,fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
