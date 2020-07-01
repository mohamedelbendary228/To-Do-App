import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  final String text;
  final Function onPressed;
  final Color color;
  final Color textColor;

  RoundedButton({
   @required this.text,
   @required this.onPressed,
    @required this.color,
    @required this.textColor,
});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: mediaQuery.size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: onPressed,
          child: Text(text, style: TextStyle(color: textColor),),
        ),
      ),
    );
  }
}
