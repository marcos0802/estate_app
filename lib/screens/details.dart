import 'package:estate_app/data/data.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Property property;
  Details({required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: Text(property.name),
        )
      ],
    ));
  }
}
