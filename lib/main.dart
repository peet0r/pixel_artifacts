import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// This is a direct port of https://www.walvisions.com/PattPages/1-alternating_pixels.html
// All credit to that page

void main() async {
  // Ensure bindings are initialized otherwise we can't user rootBundle.
  WidgetsFlutterBinding.ensureInitialized();

  // Compile the binary into a Fragment program.
  final verticalLinesProgram = await FragmentProgram.compile(
    spirv: (await rootBundle.load('assets/shaders/vertical_lines.sprv')).buffer,
  );

  // Compile the binary into a Fragment program.
  final checkerboardProgram = await FragmentProgram.compile(
    spirv: (await rootBundle.load('assets/shaders/checkerboard.sprv')).buffer,
  );

  runApp(FlutterShaderTest(
      vertical: verticalLinesProgram, checkerboard: checkerboardProgram));
}

/// Wrapper around the [ShaderPainter]. Nothing fancy here.
class FlutterShaderTest extends StatelessWidget {
  const FlutterShaderTest(
      {Key? key, required this.vertical, required this.checkerboard})
      : super(key: key);

  final FragmentProgram vertical;
  final FragmentProgram checkerboard;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: ShaderPainter(vertical, checkerboard));
  }
}

/// Renderer used for rendering and testing our shaders.
class ShaderPainter extends CustomPainter {
  ShaderPainter(this.vertical, this.checkerboard);

  late final FragmentProgram vertical;
  late final FragmentProgram checkerboard;

  Paint _vertical = Paint();
  Paint _checkerboard = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    // Turn it into a shader with given inputs (floatUniforms).
    _checkerboard = Paint()
      ..shader = checkerboard.shader(
        floatUniforms: Float32List.fromList(<double>[size.width, size.height]),
      );

    // Turn it into a shader with given inputs (floatUniforms).
    _vertical = Paint()
      ..shader = vertical.shader(
        floatUniforms: Float32List.fromList(<double>[size.width, size.height]),
      );

    double side = 80;
    double mid = size.height / 2;
    double top = mid;
    double bottom = mid;
    while (top > 0) {
      if (((mid - top) / side) % 2 == 0) {
        canvas.drawRect(
            Rect.fromLTWH(0, top - side - 1, size.width, side), _vertical);
      } else {
        canvas.drawRect(
            Rect.fromLTWH(0, top - side - 1, size.width, side), _checkerboard);
      }
      top -= side;
    }

    while (bottom < size.height + side) {
      if (((mid - bottom) / side) % 2 == 0) {
        canvas.drawRect(
            Rect.fromLTWH(0, bottom - side + 1, size.width, side), _vertical);
      } else {
        canvas.drawRect(Rect.fromLTWH(0, bottom - side + 1, size.width, side),
            _checkerboard);
      }
      bottom += side;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
