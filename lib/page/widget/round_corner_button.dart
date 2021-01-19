import 'package:flutter/material.dart';

class RoundCornerButton extends StatelessWidget {
  final String text;
  final Function function;
  // Color textColor;
  // Color bgColor;


  RoundCornerButton(this.text, this.function);


  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          // color: Theme
          //     .of(context)
          //     .primaryColor,
          gradient: LinearGradient(
            colors: [ const Color(0xff03a9f4),const Color(0xff0288d1),]
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
          child: Text(
            text == null ? '' : text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
        onTap: function,
      ),
    );
  }

}





