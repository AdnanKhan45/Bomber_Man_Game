import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final color;
  final child;
  final function;

  MyButton({this.color, this.child, this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: function,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: color,
            width: 40,
            height: 40,
            child: Center(child: child,),
          ),
        ),
      ),
    );
  }
}
