class TextGeneratorHelper {
  static RegExp firestorageLinkRegex =
      RegExp(r'%2F([\d\D]*\.[\D]+)\?', multiLine: false, caseSensitive: false);

  static RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static String dateToAge(DateTime date) {
    DateTime? born = date;
    DateTime today = DateTime.now();
    int yearDiff = today.year - (born.year ?? 0);
    int monthDiff = today.month - (born.month ?? 0);
    int dayDiff = today.day - (born.day ?? 0);

    String age = '';
    if (yearDiff > 0) {
      age += yearDiff.toString();
      int percentMonth = (monthDiff / 12).round();
      age += percentMonth > 0 ? '.$percentMonth' : '';
      age += ' Year';
    } else if (monthDiff > 0) {
      age += '$monthDiff Month';
    } else {
      age += '$dayDiff Day';
    }
    return age;
  }
}
