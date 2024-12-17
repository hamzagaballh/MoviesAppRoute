import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/api/api_services.dart';
import 'package:movie_app/core/Colors.dart';
import 'package:movie_app/firebase/firebase_services.dart';
import 'package:movie_app/models/details_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/slideable_model.dart';
import 'package:movie_app/screens/home_widgets/movie_details_widget.dart';
import 'package:movie_app/screens/home_widgets/recomended_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});
  static String routeName = "details";

  @override
  Widget build(BuildContext context) {
    MovieModel? movieModel =
        ModalRoute.of(context)!.settings.arguments as MovieModel;
    return Scaffold(
      backgroundColor: AppColors.primary,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: AppColors.secondary,
          child: Icon(
            Icons.arrow_back,
            color: AppColors.gold,
            size: 35,
          ),
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder(
            future: ApiServices.detailsMove(movieModel.results.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.gold,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (snapshot.hasData) {
                DetailsModel detailsModel = snapshot.data!;
                return MovieDetailsWidget(
                  detailsModel: detailsModel,
                );
              } else {
                return const Center(child: Text("No data available"));
              }
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            color: AppColors.greydark,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.02,
                right: 10,
                left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    AppLocalizations.of(context)!.more,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                FutureBuilder(
                    future: ApiServices.similarMovie(
                        movieModel.results.id.toString()),
                    builder: (context, snapshot) {
                      SlidableModel? moreLike = snapshot.data;
                      List<Results> movies = moreLike?.results ?? [];
                      return Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return FutureBuilder<bool>(
                              future: FirebaseServices.existMovie(
                                  movies[index].id.toString()),
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.gold,
                                  ));
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text("Error: ${snapshot.error}"));
                                } else if (snapshot.hasData) {
                                  MovieModel movie =
                                      MovieModel(results: movies[index]);
                                  movie.isWatchList = snapshot.data!;
                                  return RecomendedWidget(
                                    movieModel: movie,
                                  );
                                } else {
                                  return const Center(
                                      child: Text("No data available"));
                                }
                              },
                            );
                          },
                          itemCount: movies.length,
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
