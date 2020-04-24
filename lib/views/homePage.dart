import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text('Home Page', style: Theme.of(context).textTheme.headline2),
      ),
    );
  }
}
