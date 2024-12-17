import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/core/Colors.dart';
import 'package:movie_app/firebase/firebase_services.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieProvider extends ChangeNotifier {
  bool isWatch = false;
  Stream<List<MovieModel>> getMovies() async* {
    try {
      yield* FirebaseServices.getWatchList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addMovie(MovieModel movie) async {
    try {
      await FirebaseServices.addMovieWatchList(movie).then((value) {
        Fluttertoast.showToast(
            msg: "Add to Watchlist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.gold,
            textColor: Colors.white,
            fontSize: 16.0);
      });
      notifyListeners();
    } catch (e) {
      print("errrrrroorrr$e");
      Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> deleteMovie(MovieModel movie) async {
    try {
      await FirebaseServices.deleteMovieWatchList(movie);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
