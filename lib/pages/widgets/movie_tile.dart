import 'package:flutter/material.dart';

class MovieTile extends StatefulWidget {
  final String imageUrl;
  final Function onTap;
  final Function onHover;

  MovieTile({
    required this.imageUrl,
    required this.onTap,
    required this.onHover,
  });
  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      onHover: (value) => setState(() {
        isHovered = value;
        widget.onHover();
      }),
      child: Container(
        constraints: BoxConstraints(
            maxHeight: 380, maxWidth: 220, minHeight: 100, minWidth: 80),
        height: isHovered
            ? MediaQuery.of(context).size.height * 1 / 3 + 30
            : MediaQuery.of(context).size.height * 1 / 4,
        width: isHovered
            ? MediaQuery.of(context).size.width * 1 / 7 + 30
            : MediaQuery.of(context).size.width * 1 / 8,
        child: Image.network(
          widget.imageUrl,
        ),
      ),
    );
  }
}
