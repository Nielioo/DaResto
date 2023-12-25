part of '../pages.dart';

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
              child: Hero(
                tag: 'restaurantImage$imageUrl',
                child: Image.network(
                  imageUrl,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          DaSpacer.horizontal(space: Space.medium),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurantName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(FontAwesomeIcons.map, size: 12),
                  DaSpacer.horizontal(space: Space.small),
                  Text(location),
                ],
              ),
              Row(
                children: [
                  const Icon(FontAwesomeIcons.star, size: 12),
                  DaSpacer.horizontal(space: Space.small),
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
