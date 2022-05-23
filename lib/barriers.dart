import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {

  final size;

  MyBarrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      child:Image.asset("lib/images/tiya.jpg",fit: BoxFit.fill,),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(width: 10,color: Colors.grey),
        borderRadius: BorderRadius.circular(30)
      ),
    );
  }
}