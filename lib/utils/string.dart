String stringTrimRight(String str, String substring) {
  str = str.trim();
  while (true) {
    if (!str.endsWith(substring)) {
      break;
    }
    str = str.substring(0, str.length - substring.length);
  }
  return str;
}
