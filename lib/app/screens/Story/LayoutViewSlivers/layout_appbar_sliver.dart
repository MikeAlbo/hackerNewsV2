import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacker_news/app/widgets/fade_animation.dart';

class LayoutAppBarSliver extends StatefulWidget {
  final String title;
  final ScrollController scrollController;

  LayoutAppBarSliver({this.title, this.scrollController});

  @override
  _LayoutAppBarSliverState createState() => _LayoutAppBarSliverState();
}

class _LayoutAppBarSliverState extends State<LayoutAppBarSliver> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      //elevation: 0.0,
      brightness: Brightness.light,
      title: FadeAnimation(
        duration: Duration(seconds: 1),
        child: Text(
          widget.title,
          style: GoogleFonts.robotoSlab(
              color: Colors.grey[900], fontSize: 24.0, letterSpacing: 1.25),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black87),
    );
  }
}
