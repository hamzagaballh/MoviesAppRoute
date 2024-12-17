import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/api/api_services.dart';
import 'package:movie_app/core/Colors.dart';
import 'package:movie_app/firebase/firebase_services.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/slideable_model.dart';
import 'package:movie_app/screens/home_widgets/newRelease_widget.dart';
import 'package:movie_app/screens/home_widgets/recomended_widget.dart';
import 'package:movie_app/screens/home_widgets/slideable_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder(
            future: ApiServices.popularMovies(),
            builder: (context, snapshot) {
              SlidableModel? popularMovies = snapshot.data;
              List<Results> movies = popularMovies?.results ?? [];
              return CarouselSlider(
                  items: movies.map((i) {
                    return FutureBuilder<bool>(
                      future: FirebaseServices.existMovie(i.id.toString()),
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
                          MovieModel movieModel = MovieModel(results: i);
                          movieModel.isWatchList = snapshot.data!;
                          return SlideableWidget(
                            movieModel: movieModel,
                          );
                        } else {
                          return const Center(child: Text("No data available"));
                        }
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      height: MediaQuery.of(context).size.height * 0.37));
            }),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
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
                  AppLocalizations.of(context)!.newRelease,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              FutureBuilder(
                  future: ApiServices.upcomingMovies(),
                  builder: (context, snapshot) {
                    SlidableModel? upcomingMovies = snapshot.data;
                    List<Results> movies = upcomingMovies?.results ?? [];
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
                                MovieModel movieModel =
                                    MovieModel(results: movies[index]);
                                movieModel.isWatchList = snapshot.data!;
                                return NewreleaseWidget(
                                  movieModel: movieModel,
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
                  AppLocalizations.of(context)!.recommended,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              FutureBuilder(
                  future: ApiServices.topRatedMovies(),
                  builder: (context, snapshot) {
                    SlidableModel? topRatedMovie = snapshot.data;
                    List<Results> movies = topRatedMovie?.results ?? [];
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
                                MovieModel movieModel =
                                    MovieModel(results: movies[index]);
                                movieModel.isWatchList = snapshot.data!;
                                return RecomendedWidget(
                                  movieModel: movieModel,
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
      ],
    );
  }
}
