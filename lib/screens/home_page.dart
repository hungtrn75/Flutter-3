import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flare'),
      ),
      body: Center(
          child: Container(
        width: 150,
        height: 150,
        child: FlareActor(
          'assets/flare/TheHacker.flr',
          alignment: Alignment.center,
          shouldClip: false,
          fit: BoxFit.contain,
          animation: 'appear',
        ),
      )),
    );
  }
}
