import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  String title;
  String description;
  double height;
  CardWidget(
      {super.key,
      required this.title,
      required this.description,
      this.height = 60});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: height + 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 4, 30, 52),
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                )
              ],
            )),
        Container(
          width: double.infinity,
          height: height,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white, width: 2)),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, //.horizontal
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
