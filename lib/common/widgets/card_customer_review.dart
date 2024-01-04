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
                  name.length > 20 ? '${name.substring(0, 20)}...' : name,
                  style: Style.text2.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: Style.text2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Gap.h4,
            Text(
              review,
              style: Style.subText1,
            ),
          ],
        ),
      ),
    );
  }
}
