
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {

  final innerColor;
  final outerColor;
  final child;

  const MyPixel({this.innerColor, this.outerColor, this.child});


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          color: outerColor,
          padding: EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              color: innerColor,
              child: Center(child: child,),
            ),
          ),
        ),
      ),
    );
  }
}
