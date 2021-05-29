import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app_assignment/notifiers/movie_notifier.dart';
import 'package:movie_app_assignment/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieNotifier()..fetchMovieList(),
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            fontFamily: 'Poppins',
            textTheme: TextTheme(
                headline1: TextStyle(
                  fontFamily: 'Ringbearer',
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(50),
                  fontWeight: FontWeight.bold,
                ),
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.w500,
                ),
                bodyText2: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.w500,
                ),
                subtitle1: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w500,
                ),
                subtitle2: TextStyle(
                  color: Colors.white.withOpacity(.7),
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.w500,
                )),
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
