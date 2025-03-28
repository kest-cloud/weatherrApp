import 'package:flutter/material.dart';
import 'package:weatherapp/core/assets/assets.dart';

class ResponsiveImage extends StatelessWidget {
  final double width;

  const ResponsiveImage({super.key, required this.width});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double aspectRatio = width <= 300 ? 4 / 3 : 16 / 9;

        return Container(
          height: 340,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffF6F6F6)),
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: Image.asset(
              kWeatherImage,
              fit: BoxFit.fitWidth,
            ),
          ),
        );
      },
    );
  }
}
