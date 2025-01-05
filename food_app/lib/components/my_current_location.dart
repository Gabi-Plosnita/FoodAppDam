import 'package:flutter/material.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  void openLocationSearchBox(BuildContext context)
  {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Your location"),
        content: TextField(
          decoration: const InputDecoration(hintText: "Search adress.."),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver now",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
              onTap: () => openLocationSearchBox(context),
              child: Row(
                children: [
                  Text("Romania Brasov 13 decembrie nr 24"),
                  Icon(Icons.keyboard_arrow_down_rounded),
                ],
              )
          )
        ],
      ),
    );
  }
}
