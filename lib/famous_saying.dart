import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FamousSaying extends StatelessWidget {
  final String phrase;
  final String speaker;

  FamousSaying(this.phrase, this.speaker);

  @override
  Widget build(BuildContext context) {
    // return Column(mainAxisSize: MainAxisSize.min, children: [
    //   Text(phrase, style: TextStyle(fontSize: 32, color: Colors.white)),
    //   Text(speaker, style: TextStyle(fontSize: 20, color: Colors.white))
    // ]);
    return Container(
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey[600],
          offset: Offset(4, 4),
          blurRadius: 10,
          spreadRadius: 1
        ),
      ]),
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(30),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(phrase, style: TextStyle(fontSize: 23)),
        SizedBox(height: 20),
        Text(speaker, style: TextStyle(fontSize: 18))
      ])
    );
  }

  String getShareString() => '$phrase -$speaker';
}
