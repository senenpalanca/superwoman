import 'package:flutter/material.dart';
import 'package:superwoman/pallete.dart';


class DisplayCard extends StatelessWidget {
  Color color;
  Widget child;

  DisplayCard(this.child, this.color,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      width: cardHeight * cardProportion,
      child: Card(
        color: color,
        child: child,
      ),
    );
  }
}
