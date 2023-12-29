part of 'widgets.dart';

class CustomerReviewCard extends StatelessWidget {
  final String name;
  final String review;
  final String date;

  const CustomerReviewCard(
      {super.key,
      required this.name,
      required this.review,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  date,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            Text(
              review,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
