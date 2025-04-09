import 'package:flutter/material.dart';
import 'package:recipe_app/presentation/component/big_buttons.dart';
import 'package:recipe_app/presentation/component/midium_buttons.dart';
import 'package:recipe_app/presentation/component/small_buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigButton(),
            const SizedBox(height: 20),
            MidiumButton(),
            const SizedBox(height: 20),
            SmallButton()
          ],
        )
        )
    );
  }
}