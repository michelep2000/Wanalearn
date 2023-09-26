import 'package:flutter/material.dart';

class ImageBackground extends StatelessWidget {
  const ImageBackground({
    required this.image,
    required this.child,
    super.key,
  });

  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: child,
      ),
    );
  }
}
