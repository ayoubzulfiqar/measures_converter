import 'package:flutter/material.dart';
import 'package:measure_converter/homepage.dart';

void main() {
  runApp(const MeasuringConverter());
}

class MeasuringConverter extends StatelessWidget {
  const MeasuringConverter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MeasuringConversion(),
    );
  }
}
