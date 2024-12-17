import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/api/api_services.dart';
import 'package:movie_app/core/Colors.dart';
import 'package:movie_app/firebase/firebase_services.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/slideable_model.dart';
import 'package:movie_app/screens/widget/search_widgets/search_text_form_field_widget.dart';
import 'package:movie_app/screens/widget/watchList_widgets/watch_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  List<MovieModel> movies = [];
  bool isSearching = false;
  bool isLoading = false;
  Timer? debounce;

  Future<void> onSearch(String query) async {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        loadMovies();
        return;
      }

      setState(() {
        isLoading = true;
        isSearching = true;
      });

      try {
        final SlidableModel? searchResults =
            await ApiServices.searchMovie(query);
        final List<MovieModel> searchMovies = await checkWatchlist(
          searchResults?.results ?? [],
        );

        setState(() {
          movies = searchMovies;
          isLoading = false;
        });
      } catch (error) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> loadMovies() async {
    setState(() {
      isLoading = true;
      isSearching = false;
    });

    try {
      final SlidableModel? popularMovies = await ApiServices.popularMovies();
      final List<MovieModel> popularList = await checkWatchlist(
        popularMovies?.results ?? [],
      );

      setState(() {
        movies = popularList;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<MovieModel>> checkWatchlist(List<Results> results) async {
    final List<Future<MovieModel>> movieFutures = results.map((result) async {
      final bool isWatchList =
          await FirebaseServices.existMovie(result.id.toString());
      return MovieModel(results: result, isWatchList: isWatchList);
    }).toList();

    return await Future.wait(movieFutures);
  }

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.03,
        right: 20,
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchTextFormFieldWidget(
            onChanged: (value) => onSearch(value),
          ),
          const SizedBox(height: 16),
          isLoading
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.gold),
                  ),
                )
              : Expanded(
                  child: movies.isEmpty
                      ? Center(
                          child: Text(
                            isSearching
                                ? "No movies found for your search."
                                : "No movies available.",
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (_, index) {
                            return WatchCard(
                              movieModel: movies[index],
                            );
                          },
                          itemCount: movies.length,
                          separatorBuilder: (_, index) => const Divider(),
                        ),
                ),
        ],
      ),
    );
  }
}
