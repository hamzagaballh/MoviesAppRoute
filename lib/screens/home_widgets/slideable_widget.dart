import 'package:flutter/material.dart';
import 'package:movie_app/api/api_consts.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/home_widgets/movie_details_screen.dart';
import 'package:provider/provider.dart';

class SlideableWidget extends StatefulWidget {
  const SlideableWidget({super.key, required this.movieModel});

  final MovieModel? movieModel;

  @override
  State<SlideableWidget> createState() => _SlideableWidgetState();
}

class _SlideableWidgetState extends State<SlideableWidget> {
  @override
  Widget build(BuildContext context) {
    String yearDate = widget.movieModel!.results.releaseDate != null &&
            widget.movieModel!.results.releaseDate!.length >= 4
        ? widget.movieModel!.results.releaseDate!.substring(0, 4)
        : "N/A";
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(MovieDetailsScreen.routeName,
            arguments: widget.movieModel);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.37,
        child: Stack(
          children: [
            Image.network(
              ApiConsts.imageUrl + widget.movieModel!.results.backdropPath!,
              fit: BoxFit.contain,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(ApiConsts.imageUrl +
                              widget.movieModel!.results.posterPath!),
                          fit: BoxFit.fill)),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        widget.movieModel!.isWatchList =
                            !widget.movieModel!.isWatchList;
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movieModel!.results.originalTitle ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        yearDate,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w300),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
