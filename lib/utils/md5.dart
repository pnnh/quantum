import 'dart:convert';
import 'package:crypto/crypto.dart';

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

String generateMd5ForUUID(String input) {
  var md5Str = generateMd5(input);
  return '${md5Str.substring(0, 8)}-${md5Str.substring(8, 12)}-${md5Str.substring(12, 16)}-${md5Str.substring(16, 20)}-${md5Str.substring(20)}';
}
