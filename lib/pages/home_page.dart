import 'package:flutter/material.dart';
import 'package:movie_app_assignment/notifiers/movie_notifier.dart';
import 'package:movie_app_assignment/pages/movie_details_page.dart';
import 'package:movie_app_assignment/pages/widgets/movie_tile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  ValueNotifier<int> backdropNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Consumer<MovieNotifier>(
            builder: (context, notifier, child) {
              if (notifier.movieList == null) {
                return Center(child: LinearProgressIndicator());
              } else {
                return Stack(
                  fit: StackFit.loose,
                  alignment: FractionalOffset.bottomCenter,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: backdropNotifier,
                      builder: (context, value, child) => Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.5),
                                    BlendMode.dstATop),
                                image: NetworkImage(
                                  '$imageBaseUrl/original/${notifier.movieList![value].backdropPath}',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1,
                              left: MediaQuery.of(context).size.width * 0.2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notifier.movieList![value].title,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: notifier
                                            .movieList![value].voteAverage
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        children: [
                                      TextSpan(
                                        text: '/10',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!,
                                      )
                                    ])),
                                Text(
                                  notifier.movieList![value].releaseDate.year
                                      .toString(),
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .5,
                      constraints: BoxConstraints(
                        maxHeight: 350,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: notifier.movieList!.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 20),
                        itemBuilder: (context, index) {
                          return MovieTile(
                            imageUrl:
                                '$imageBaseUrl/original/${notifier.movieList![index].posterPath}',
                            onTap: () {
                              notifier.selectedMovieId =
                                  notifier.movieList![index].id;
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MovieDetailsPage(),
                                settings: RouteSettings(
                                    name:
                                        '${notifier.movieList![index].title}'),
                              ));
                            },
                            onHover: () {
                              backdropNotifier.value = index;
                            },
                          );
                        },
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ));
  }
}
