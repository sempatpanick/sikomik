String snakeToTitleCase(String input) {
  return input
      .replaceAllMapped(
        RegExp(r'(^|_)(\w)'),
        (match) => ' ${match.group(2)!.toUpperCase()}',
      )
      .trim();
}
