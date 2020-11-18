import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {this.color,
      @required this.title,
      @required this.onPress,
      this.textColor,
      this.imgUrl,this.fontsize});
  final Function onPress;
  final Color color;
  final String title;
  final Color textColor;
  final String imgUrl;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FlatButton(
        onPressed: onPress,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imgUrl!=null?
            Image.asset(
              imgUrl,
              height: 30.0,
            ):Container(),
            SizedBox(
              width: 10.0,
            ),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: fontsize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Padding(
// padding: EdgeInsets.symmetric(horizontal: 40.0),
// child: Material(
// elevation: 6.0,
// color: color,
// borderRadius: BorderRadius.circular(30.0),
// child: MaterialButton(
// onPressed: onPress,
// minWidth: 200.0,
// height: 42.0,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Image.asset('images/icons8-iphone-x-100.png'),
// Text(
// title,
// style: TextStyle(color: textColor),
// ),
// ],
// ),
// ),
// ),
// );
