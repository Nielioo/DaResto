import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String restaurantName;
  final String location;
  final String rating;

  const RestaurantCard({
    super.key,
    required this.imageUrl,
    required this.restaurantName,
    required this.location,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurantName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(FontAwesomeIcons.map, size: 12),
                  const SizedBox(width: 8),
                  Text(location),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(FontAwesomeIcons.star, size: 12),
                  const SizedBox(width: 8),
                  Text(rating),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
