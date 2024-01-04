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
            Lottie.asset('assets/lottie/not_found.json', width: 200),
            Gap.h8,
            Text(
              text,
              style: Style.text1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
