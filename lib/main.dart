import 'package:flutter/material.dart';
import 'package:flutter_openai_app/provider/prediction_provider.dart';
import 'package:provider/provider.dart';

import 'view/prediction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PredictionProvider>(
      create: (context) => PredictionProvider(),
      child: MaterialApp(
        title: 'Prediction App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const PredictionScreen(),
      ),
    );
  }
}
