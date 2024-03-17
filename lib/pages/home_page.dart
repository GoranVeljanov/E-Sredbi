import 'package:flutter/material.dart';
import 'event_details.dart'; // Import the event details page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Events'),
      ),
      body: ListView(
        children: const [
          EventItem(
            name: 'Beer and JS',
            date: 'May 15, 2024',
            location: 'Pub XYZ',
            imageUrl: 'beer_and_js.jpg',
          ),
          EventItem(
            name: 'Tech Conference',
            date: 'June 20, 2024',
            location: 'Convention Center',
            imageUrl: 'tech_conference.jpg',
          ),
          EventItem(
            name: 'Art Exhibition',
            date: 'July 5, 2024',
            location: 'Art Gallery',
            imageUrl: 'art_exhibition.jpg',
          ),
          EventItem(
            name: 'Music Festival',
            date: 'August 10, 2024',
            location: 'Outdoor Arena',
            imageUrl: 'music_festival.jpg',
          ),
        ],
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final String name;
  final String date;
  final String location;
  final String imageUrl;

  const EventItem({super.key, 
    required this.name,
    required this.date,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Navigate to event details page when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(
              name: name,
              date: date,
              location: location,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      leading: Image.asset(imageUrl),
      title: Text(name),
      subtitle: Text('$date • $location'),
    );
  }
}
