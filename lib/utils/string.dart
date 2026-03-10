extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

/// Parses a version string into a list of numeric components.
///
/// Strips a leading `v` or `V`, ignores any pre-release suffix (e.g. `-alpha`),
/// and returns each dot-separated segment as an integer.
List<int> parseVersion(String version) {
  final String clean =
      (version.startsWith('v') || version.startsWith('V'))
          ? version.substring(1)
          : version;
  final String numericPart = clean.split('-').first;
  return numericPart
      .split('.')
      .map((part) => int.tryParse(part) ?? 0)
      .toList();
}

/// Returns `true` if [latest] is a newer semantic version than [current].
bool isNewerVersion(String latest, String current) {
  final List<int> latestParts = parseVersion(latest);
  final List<int> currentParts = parseVersion(current);
  final int length = latestParts.length > currentParts.length
      ? latestParts.length
      : currentParts.length;
  for (int i = 0; i < length; i++) {
    final int latestPart = i < latestParts.length ? latestParts[i] : 0;
    final int currentPart = i < currentParts.length ? currentParts[i] : 0;
    if (latestPart > currentPart) return true;
    if (latestPart < currentPart) return false;
  }
  return false;
}
