String toUpperCamelCase(String text) {
  return text
      .split(RegExp(r'[\s_\-]+')) // Split by whitespace, underscores, or hyphens
      .map((word) => word.isNotEmpty
      ? word[0].toUpperCase() + word.substring(1).toLowerCase()+' '
      : '')
      .join();
}