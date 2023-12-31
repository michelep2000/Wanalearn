import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wanalearn/core/common/widgets/image_background.dart';
import 'package:wanalearn/core/resources/colours.dart';
import 'package:wanalearn/core/resources/media.dart';

class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageBackground(
        image: Media.onBoardingBackground,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ups! this page is under construction',
                style: TextStyle(
                  fontSize: 30,
                  color: Colours.neutralTextColour,
                ),
              ),
              Lottie.asset(
                Media.pageUnderConstruction,
              ),
              Visibility(
                visible: GoRouter.of(context).canPop(),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colours.neutralTextColour,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => GoRouter.of(context).pop(),
                  child: const Text(
                    'Go back',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
