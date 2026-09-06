---
inject: true
before: part
to: "lib/ui/screens/<%= h.changeCase.snake(name) %>/<%= h.changeCase.snake(name) %>.dart"
skip_if: momentum/services/fault/faults.dart
---
import 'package:momentum/services/fault/faults.dart';
