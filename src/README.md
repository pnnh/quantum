## 生成native库

```bash
# 配置cmake
cmake --preset macos
# 生成native库
cmake --build --preset macos #--config Release
# 安装native库到指定目录
cmake --install build/macos --config Debug
```

### 创建xcframework
```bash
xcodebuild -create-xcframework -framework quantum/Frameworks/MTQuantum.framework -output quantum/Frameworks/MTQuantum.xcframework
```