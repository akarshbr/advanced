import 'dart:math';
import 'package:flutter/material.dart';
import '../model/movie.dart';

final List<Movie> movieList = List.generate(
    51, (index) => Movie(title: "Movie$index", time: "${Random().nextInt(100) + 60}min"));

class MovieProvider extends ChangeNotifier {
  final List<Movie> _movies = movieList;

  List<Movie> get movies => _movies;

  final List<Movie> _wishList = [];

  List<Movie> get wishList => _wishList;

  void addWishList(Movie selectedMovie) {
    wishList.add(selectedMovie);
    notifyListeners();
  }

  void removeWishList(Movie selectedMovie) {
    wishList.remove(selectedMovie);
    notifyListeners();
  }
}
