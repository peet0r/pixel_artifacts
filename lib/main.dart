import 'package:flutter/material.dart';

// This is a direct port of https://www.walvisions.com/PattPages/1-alternating_pixels.html
// All credit to that page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            repeat: ImageRepeat.repeat,
          image: AssetImage('assets/images/altpixels.png')
      )),
);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: PixelArtifact());
  }
}

class PixelArtifact extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size){

  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}