import 'package:flutter/material.dart';


class Mycontainer extends StatelessWidget {

  Mycontainer({this.title,this.alignmentGeometry,this.edgeInsetsGeometry,this.size,this.textcolor,this.fontWeight});
  final String title;
  final AlignmentGeometry alignmentGeometry;
  final EdgeInsetsGeometry edgeInsetsGeometry;
  final double size;
  final Color textcolor;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: edgeInsetsGeometry,
      alignment: alignmentGeometry,
      child: Text(
        title,
        style: TextStyle(
            color: textcolor,
            fontSize: size,
            fontWeight: fontWeight,
        ),
      ),
    );
  }
}
