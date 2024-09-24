import 'dart:math';
import 'dart:ui';

// 生成随机颜色值
Color generateRandomColor() {
  Random random = Random();
  return Color.fromARGB(255, 155 + random.nextInt(100),
      155 + random.nextInt(100), 155 + random.nextInt(100));
}