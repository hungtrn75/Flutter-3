import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final String color;
  final Widget child;
  final String value;
  const Badge({
    Key key,
    @required this.child,
    @required this.value,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        child,
        value != '0'
            ? Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color != null ? color : Colors.redAccent,
                  ),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
