import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/api/api_services.dart';
import 'package:movie_app/models/genres_model.dart';
import 'package:movie_app/screens/widget/browse_widgets.dart/browse_card.dart';
import 'package:movie_app/screens/widget/browse_widgets.dart/browse_genres_screen.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.06, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.bc,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          FutureBuilder(
              future: ApiServices.genresList(),
              builder: (context, snapshot) {
                GenresModel? topRatedMovie = snapshot.data;
                List<Genres> genres = topRatedMovie?.genres ?? [];
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 3),
                        ),
                        itemCount: genres.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  BrowseGenresScreen.routeName,
                                  arguments: genres[index]);
                            },
                            child: BrowseCard(
                              title: genres[index].name,
                            ),
                          );
                        }),
                  ),
                );
              })
        ],
      ),
    );
  }
}
