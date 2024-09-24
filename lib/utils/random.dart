import 'dart:math';

// 生成随机字符串
String generateRandomString(int length) {
  var random = Random();
  return String.fromCharCodes(List.generate(length, (index) => random.nextInt(33) + 89));
}