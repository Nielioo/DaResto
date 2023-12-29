part of 'widgets.dart';

class DaSpacer {
  static SizedBox horizontal({double space = 8}) {
    return SizedBox(
      width: space,
    );
  }

  static SizedBox vertical({double space = 8}) {
    return SizedBox(
      height: space,
    );
  }
}
