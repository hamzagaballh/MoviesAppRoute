import 'package:flutter/material.dart';
import 'package:movie_app/api/api_consts.dart';
import 'package:movie_app/core/Colors.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/home_widgets/movie_details_screen.dart';
import 'package:provider/provider.dart';

class RecomendedWidget extends StatefulWidget {
  const RecomendedWidget({super.key, required this.movieModel});

  final MovieModel? movieModel;

  @override
  State<RecomendedWidget> createState() => _RecomendedWidgetState();
}

class _RecomendedWidgetState extends State<RecomendedWidget> {
  @override
  Widget build(BuildContext context) {
    final movieResults = widget.movieModel!.results;
    final yearDate = widget.movieModel!.results.releaseDate != null &&
            widget.movieModel!.results.releaseDate!.length >= 4
        ? widget.movieModel!.results.releaseDate!.substring(0, 4)
        : "N/A";
    final posterPath = movieResults.posterPath ?? "";
    final isWatchList = widget.movieModel!.isWatchList;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(MovieDetailsScreen.routeName,
            arguments: widget.movieModel);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.20,
        width: MediaQuery.of(context).size.width * 0.33,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width * 0.33,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.transparent,
                image: posterPath.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(ApiConsts.imageUrl + posterPath),
                        fit: BoxFit.fill,
                      )
                    : null, // Handle cases with no poster
              ),
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    widget.movieModel!.isWatchList = !isWatchList;
                  });

                  final updatedMovie = widget.movieModel!.copyWith(
                    results: movieResults,
                    isWatchList: !isWatchList,
                  );

                  final movieProvider =
                      Provider.of<MovieProvider>(context, listen: false);

                  if (updatedMovie.isWatchList) {
                    movieProvider.addMovie(updatedMovie);
                  } else {
                    movieProvider.deleteMovie(updatedMovie);
                  }
                },
                child: Image.asset(
                  isWatchList
                      ? "assets/bookmark.png"
                      : "assets/notbookmark.png",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.gold,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          movieResults.voteAverage.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      movieResults.originalTitle ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      yearDate,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 10, fontWeight: FontWeight.w300),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
