# quantum

A new flutter plugin project.

## 生成native库

```bash
# 配置cmake
cmake --preset macOS
# 生成native库
cmake --build --preset macOS --config Release
# 安装native库到指定目录
cmake --install build/macOS --config Release
```

## 生成本机代码绑定

```bash
dart run ffigen
dart run ffigen --config macos/ffigen.yaml
```

## 生成模型

```shell
# 生成JSON等序列化模型
dart run build_runner build --delete-conflicting-outputs
# 生成pigeon代码存根
dart run pigeon --input src/pigeon.dart
```