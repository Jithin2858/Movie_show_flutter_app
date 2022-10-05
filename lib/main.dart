import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task4/screens/main_screen.dart';
import 'package:task4/screens/movie_details_screen.dart';

void main() {
  runApp(const MyApp());
 // HttpOverrides.global = MyHttpOverrides();
}
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
//}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      routes: {
        MovieDetailScreen.routeName: (ctx)=>MovieDetailScreen()
      },
    );
  }
}

