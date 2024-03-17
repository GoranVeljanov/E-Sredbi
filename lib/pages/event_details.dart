import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final String name;
  final String date;
  final String location;
  final String imageUrl;

  const EventDetailsPage({super.key, 
    required this.name,
    required this.date,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imageUrl),
          Text('Date: $date'),
          Text('Location: $location'),
        ],
      ),
    );
  }
}
