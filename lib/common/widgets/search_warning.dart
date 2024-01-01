part of 'widgets.dart';

class SearchWarning extends StatelessWidget {
  final String text;

  const SearchWarning({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_rounded,
              size: 72,
            ),
            Gap.h4,
            Text(
              text,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
