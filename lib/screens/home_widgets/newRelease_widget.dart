import 'package:flutter/material.dart';
import 'package:movie_app/api/api_consts.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/home_widgets/movie_details_screen.dart';
import 'package:provider/provider.dart';

class NewreleaseWidget extends StatefulWidget {
  const NewreleaseWidget({super.key, required this.movieModel});

  final MovieModel? movieModel;

  @override
  State<NewreleaseWidget> createState() => _NewreleaseWidgetState();
}

class _NewreleaseWidgetState extends State<NewreleaseWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(MovieDetailsScreen.routeName,
            arguments: widget.movieModel);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.topLeft,
        height: MediaQuery.of(context).size.height * 0.20,
        width: MediaQuery.of(context).size.width * 0.33,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.transparent,
            image: DecorationImage(
                image: NetworkImage(ApiConsts.imageUrl +
                    widget.movieModel!.results.posterPath!),
                fit: BoxFit.fill)),
        child: GestureDetector(
          onTap: () async {
            setState(() {
              widget.movieModel!.isWatchList = !widget.movieModel!.isWatchList;
            });

            MovieModel updatedMovie = widget.movieModel!.copyWith(
              results: widget.movieModel?.results,
              isWatchList: widget.movieModel!.isWatchList,
            );
            if (updatedMovie.isWatchList) {
              Provider.of<MovieProvider>(context, listen: false)
                  .addMovie(updatedMovie);
            } else {
              Provider.of<MovieProvider>(context, listen: false)
                  .deleteMovie(updatedMovie);
            }
          },
          child: widget.movieModel!.isWatchList
              ? Image.asset("assets/bookmark.png")
              : Image.asset("assets/notbookmark.png"),
        ),
      ),
    );
  }
}
