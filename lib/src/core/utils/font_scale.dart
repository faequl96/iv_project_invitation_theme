class FontScale {
  const FontScale._();

  static late double x5s;
  static late double x4s;
  static late double x3s;
  static late double x2s;
  static late double xs;
  static late double sm;
  static late double md;
  static late double lg;
  static late double xl;
  static late double x2l;
  static late double x3l;
  static late double x4l;
  static late double x5l;
  static late double x6l;
  static late double x7l;
  static late double x8l;
  static late double x9l;
  static late double x10l;
  static late double x11l;
  static late double x12l;
  static late double x13l;
  static late double x14l;
  static late double x15l;

  static void set(double screenWidth) {
    final factor = screenWidth / 375;
    x5s = 8 * factor;
    x4s = 9 * factor;
    x3s = 10 * factor;
    x2s = 11 * factor;
    xs = 12 * factor;
    sm = 13 * factor;
    md = 14 * factor;
    lg = 15 * factor;
    xl = 16 * factor;
    x2l = 18 * factor;
    x3l = 20 * factor;
    x4l = 22 * factor;
    x5l = 24 * factor;
    x6l = 26 * factor;
    x7l = 28 * factor;
    x8l = 30 * factor;
    x9l = 32 * factor;
    x10l = 36 * factor;
    x11l = 40 * factor;
    x12l = 44 * factor;
    x13l = 48 * factor;
    x14l = 56 * factor;
    x15l = 64 * factor;
  }
}
