import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_assignment/notifiers/movie_notifier.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  double breakPoint500 = 500;
  double breakPoint1000 = 1000;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      MovieNotifier notifier = context.read<MovieNotifier>();
      notifier.fetchMovieDetails();
    });
    super.initState();
  }

  double get _descriptionTopSpace =>
      MediaQuery.of(context).size.height < breakPoint500
          ? MediaQuery.of(context).size.height / 4
          : (MediaQuery.of(context).size.height / 2 -
              (ScreenUtil().setWidth(150) > 150
                  ? 150
                  : ScreenUtil().setWidth(150)));
  double get _descriptionLeftSpace => MediaQuery.of(context).size.width <
          breakPoint1000
      ? 20
      : (ScreenUtil().setWidth(150) > 150 ? 150 : ScreenUtil().setWidth(150));

  String getRunTime(int time) {
    return '${time ~/ 60}h ${time % 60}min';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<MovieNotifier>(builder: (context, notifier, snapshot) {
        if (notifier.selectedMovieDetails == null) {
          return Center(child: LinearProgressIndicator());
        }
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + 600,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(maxHeight: 600),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(
                        '$imageBaseUrl/original/${notifier.selectedMovieDetails!.backdropPath}',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  top: _descriptionTopSpace,
                  left: _descriptionLeftSpace,
                  bottom: 20,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Wrap(
                        runSpacing: 30,
                        spacing: 30,
                        alignment:
                            MediaQuery.of(context).size.width < breakPoint1000
                                ? WrapAlignment.center
                                : WrapAlignment.start,
                        crossAxisAlignment:
                            MediaQuery.of(context).size.width < breakPoint1000
                                ? WrapCrossAlignment.center
                                : WrapCrossAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment:
                                  MediaQuery.of(context).size.width <
                                          breakPoint1000
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      maxHeight: 300, maxWidth: 200),
                                  width: ScreenUtil().setWidth(200),
                                  height: ScreenUtil().setHeight(300),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        '$imageBaseUrl/original/${notifier.selectedMovieDetails!.posterPath}',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  constraints: BoxConstraints(
                                      maxHeight: 100, maxWidth: 200),
                                  width: ScreenUtil().setWidth(200),
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    spacing: 20,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              text: notifier
                                                  .selectedMovieDetails!
                                                  .voteAverage
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
                                          'Votes : ${notifier.selectedMovieDetails!.voteCount}'
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width < 1000
                                ? double.infinity
                                : MediaQuery.of(context).size.width / 3,
                            margin: MediaQuery.of(context).size.width < 1000
                                ? EdgeInsets.only(top: 30)
                                : EdgeInsets.only(
                                    top: ScreenUtil().setHeight(200) > 200
                                        ? 200
                                        : ScreenUtil().setHeight(200)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                                  MediaQuery.of(context).size.width < 1000
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notifier.selectedMovieDetails!.title,
                                  textAlign:
                                      MediaQuery.of(context).size.width < 1000
                                          ? TextAlign.center
                                          : TextAlign.start,
                                  maxLines: 3,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                Text(
                                  notifier.selectedMovieDetails!.tagline,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Wrap(
                                    spacing: 20,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      if (notifier.selectedMovieDetails!.adult)
                                        Text(
                                          '18+',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                      Container(
                                        height: 20,
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: notifier
                                                .selectedMovieDetails!
                                                .genres
                                                .length,
                                            separatorBuilder:
                                                (context, index) => Text('・',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2),
                                            itemBuilder: (context, index) {
                                              return Text(
                                                notifier.selectedMovieDetails!
                                                    .genres[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              );
                                            }),
                                      ),
                                      Text(
                                        getRunTime(notifier
                                            .selectedMovieDetails!.runtime),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      Text(
                                        DateFormat('dd MMM yyyy').format(
                                            notifier.selectedMovieDetails!
                                                .releaseDate),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 30),
                                  width: MediaQuery.of(context).size.width <
                                          1000
                                      ? MediaQuery.of(context).size.width / 1.5
                                      : MediaQuery.of(context).size.width / 3,
                                  child: Text(
                                    notifier.selectedMovieDetails!.overview,
                                    textAlign: TextAlign.left,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 30,
                  child: BackButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
