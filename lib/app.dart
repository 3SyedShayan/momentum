import 'package:flutter/material.dart';
import 'package:momentum/configs/configs.dart';
import 'package:provider/provider.dart';

class Momentum extends StatefulWidget {
  const Momentum({super.key});

  @override
  State<Momentum> createState() => _MomentumState();
}

class _MomentumState extends State<Momentum> {
  @override
  Widget build(BuildContext context) {
    App.init(context);
    return MultiProvider(providers: [
      
    ]
    
    );
  }
}
