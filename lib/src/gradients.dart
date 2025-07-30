import "dart:ui";

abstract class GradientColors {
  /// Razer Chroma colors
  ///
  /// extracted from the login websites css code
  ///
  /// their animations uses a duration of 1400ms
  static const List<Color> razerChroma = [
    Color.fromARGB(255, 0, 255, 255),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 255, 165, 0),
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 0, 191),
    Color.fromARGB(255, 128, 0, 128),
    Color.fromARGB(255, 0, 0, 255),
  ];

  /// legacy flag
  static const List<Color> pride = [
    PrideColors.hotPink,
    PrideColors.red,
    PrideColors.orange,
    PrideColors.yellow,
    PrideColors.green,
    PrideColors.turquoise,
    PrideColors.blue,
    PrideColors.purple,
  ];

  /// pride flag since 2017
  static const List<Color> philadelphiaPride = [
    PrideColors.black,
    PrideColors.brown,
    PrideColors.hotPink,
    PrideColors.red,
    PrideColors.orange,
    PrideColors.yellow,
    PrideColors.green,
    PrideColors.turquoise,
    PrideColors.blue,
    PrideColors.purple,
  ];

  /// from Michael Page 1998
  static const List<Color> bisexualPride = [
    PrideColors.biDarkPink,
    PrideColors.biDarkPink,
    PrideColors.biDarkPurple,
    PrideColors.biDarkBlue,
    PrideColors.biDarkBlue,
  ];

  static const List<Color> lesbianPride = [
    PrideColors.lesbianDarkOrange,
    PrideColors.lesbianLightOrange,
    PrideColors.white,
    PrideColors.lesbianLightPink,
    PrideColors.lesbianDarkPink,
  ];

  /// from Monica Helms 1999
  static const List<Color> transPride = [
    PrideColors.transBlue,
    PrideColors.transPink,
    PrideColors.white,
    PrideColors.transPink,
    PrideColors.transBlue,
  ];

  static const List<Color> nonBinaryPride = [
    PrideColors.nonBinaryYellow,
    PrideColors.white,
    PrideColors.nonBinaryPurple,
    PrideColors.black,
  ];
}

/// colors based on
/// https://www.pantone.com/eu/de/artikel/color-news/die-bedeutung-aller-farben-der-pride-flag
abstract class PrideColors {
  /// PANTONE Black C
  static const Color black = Color.fromARGB(255, 45, 41, 38);

  /// PANTONE 731 C
  static const Color brown = Color.fromARGB(255, 120, 66, 19);

  /// sexuality
  ///
  /// PANTONE 812 C
  static const Color hotPink = Color.fromARGB(255, 254, 95, 162);

  /// life
  ///
  /// PANTONE 2347 C
  static const Color red = Color.fromARGB(255, 225, 7, 0);

  /// healing
  ///
  /// PANTONE 2018 C
  static const Color orange = Color.fromARGB(255, 255, 118, 1);

  /// sunlight
  ///
  /// PANTONE 3945 C
  static const Color yellow = Color.fromARGB(255, 242, 229, 0);

  /// nature
  ///
  /// PANTONE 356 C
  static const Color green = Color.fromARGB(255, 2, 123, 51);

  /// art and magic
  ///
  /// PANTONE 3262 C
  static const Color turquoise = Color.fromARGB(255, 1, 191, 179);

  /// harmony and peace
  ///
  /// PANTONE 2726 C
  static const Color blue = Color.fromARGB(255, 71, 91, 199);

  /// spirit of the LGBTQ+ community
  ///
  /// PANTONE 253 C
  static const Color purple = Color.fromARGB(255, 71, 91, 199);

  /// PANTONE 226 C
  static const Color biDarkPink = Color.fromARGB(255, 207, 0, 111);

  /// PANTONE 258 C
  static const Color biDarkPurple = Color.fromARGB(255, 141, 71, 154);

  /// PANTONE 286 C
  static const Color biDarkBlue = Color.fromARGB(255, 0, 50, 161);

  /// PANTONE 2349 C
  static const Color lesbianDarkOrange = Color.fromARGB(255, 203, 54, 3);

  /// PANTONE 1565 C
  static const Color lesbianLightOrange = Color.fromARGB(255, 255, 159, 106);

  static const Color white = Color.fromARGB(255, 255, 255, 255);

  /// PANTONE 674 C
  static const Color lesbianLightPink = Color.fromARGB(255, 197, 87, 153);

  /// PANTONE 234 C
  static const Color lesbianDarkPink = Color.fromARGB(255, 163, 1, 103);

  /// PANTONE 305 C
  static const Color transBlue = Color.fromARGB(255, 89, 202, 232);

  /// PANTONE 700 C
  static const Color transPink = Color.fromARGB(255, 242, 172, 184);

  /// PANTONE 394 C
  static const Color nonBinaryYellow = Color.fromARGB(255, 236, 233, 58);

  /// PANTONE 265 C
  static const Color nonBinaryPurple = Color.fromARGB(255, 143, 99, 205);
}
