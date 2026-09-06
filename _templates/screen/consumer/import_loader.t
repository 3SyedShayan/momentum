---
inject: true
before: part
to: "lib/ui/screens/<%= h.changeCase.snake(name) %>/<%= h.changeCase.snake(name) %>.dart"
skip_if: momentum/ui/widgets/core/loader/full_screen_loader.dart
---
import 'package:momentum/ui/widgets/core/loader/full_screen_loader.dart';
