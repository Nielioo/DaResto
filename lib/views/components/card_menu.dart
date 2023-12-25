part of '../pages.dart';

class MenuCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const MenuCard({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: MediaQuery.of(context).size.width * 0.2,
              fit: BoxFit.cover,
            ),
            DaSpacer.vertical(space: Space.small),
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
