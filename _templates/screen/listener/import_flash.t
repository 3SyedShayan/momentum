---
inject: true
before: part
to: "lib/ui/screens/<%= h.changeCase.snake(name) %>/<%= h.changeCase.snake(name) %>.dart"
skip_if: momentum/utils/flash.dart
---
import 'package:momentum/utils/flash.dart';
