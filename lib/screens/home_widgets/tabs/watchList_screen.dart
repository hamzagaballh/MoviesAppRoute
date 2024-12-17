import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/core/Colors.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/widget/watchList_widgets/watch_card.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.06, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.watchList,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          StreamBuilder<List<MovieModel>?>(
              stream: Provider.of<MovieProvider>(context, listen: false)
                  .getMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.gold,
                      ),
                    ),
                  );
                } else {
                  var data = snapshot.data;

                  if (data == null || data.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.noWatchList,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 22),
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        return WatchCard(
                          movieModel: data[index],
                        );
                      },
                      itemCount: data.length,
                      separatorBuilder: (_, index) {
                        return const Divider();
                      },
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
