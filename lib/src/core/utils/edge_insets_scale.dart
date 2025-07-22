class EdgeInsetsScale {
  const EdgeInsetsScale._();

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
    x5s = 2 * factor;
    x4s = 3 * factor;
    x3s = 4 * factor;
    x2s = 6 * factor;
    xs = 8 * factor;
    sm = 10 * factor;
    md = 12 * factor;
    lg = 14 * factor;
    xl = 16 * factor;
    x2l = 18 * factor;
    x3l = 20 * factor;
    x4l = 24 * factor;
    x5l = 28 * factor;
    x6l = 32 * factor;
    x7l = 36 * factor;
    x8l = 40 * factor;
    x9l = 48 * factor;
    x10l = 56 * factor;
    x11l = 64 * factor;
    x12l = 72 * factor;
    x13l = 80 * factor;
    x14l = 88 * factor;
    x15l = 96 * factor;
  }
}
