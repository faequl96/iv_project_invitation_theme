class AppUtils {
  const AppUtils._();

  static String toCapitalize(String value) {
    if (value.trim().isEmpty) return '';

    return value
        .split(' ')
        .map((part) {
          if (part.isEmpty) return '';
          return part[0].toUpperCase() + part.substring(1).toLowerCase();
        })
        .join(' ');
  }

  static String toSpaceFromStrip(String value) => value.trim().replaceAll('-', ' ');

  static String toUnderScoreFromStrip(String value) => value.replaceAll('-', '_');

  static String toUnderScoreFromSpace(String value) => value.replaceAll(' ', '_');
}
