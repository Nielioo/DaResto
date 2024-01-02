part of 'shared.dart';

class ValueConverter {
  bool stringToBool(String str) {
    if (str == 'true') {
      return true;
    } else if (str == 'false') {
      return false;
    } else {
      throw ArgumentError('Expected a String of either "true" or "false".');
    }
  }
}
