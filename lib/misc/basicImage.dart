
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Это тот самый виджет с картинкой'),
              Image( image:AssetImage('assets/deathconsciousness.png')),
            ]
        )
    );
  }
}



