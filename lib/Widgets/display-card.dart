import 'package:flutter/material.dart';
import 'package:superwoman/pallete.dart';

class DisplayCard extends StatefulWidget {
  Color color;
  Widget child;
  DisplayCard(this.child, this.color, {Key? key}) : super(key: key);

  @override
  _DisplayCardState createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  @override
  Widget build(BuildContext context) {
    return Container(

      height: cardHeight,
      width:  cardHeight*cardProportion,

      child: Card(
        color: widget.color,
        child: widget.child ,
      ),
    );
  }
}
