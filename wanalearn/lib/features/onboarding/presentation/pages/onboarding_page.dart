import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wanalearn/core/common/pages/loading_page.dart';
import 'package:wanalearn/core/common/widgets/image_background.dart';
import 'package:wanalearn/core/config/router/app_router.dart';
import 'package:wanalearn/core/config/router/utils/routes.dart';
import 'package:wanalearn/core/di/dependency_injection.dart';
import 'package:wanalearn/core/resources/colours.dart';
import 'package:wanalearn/core/resources/media.dart';
import 'package:wanalearn/features/onboarding/domain/entities/page_content.dart';
import 'package:wanalearn/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:wanalearn/features/onboarding/presentation/widgets/onboarding_body.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    context.read<OnboardingBloc>().add(const CheckIfUserFirstTimeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is CheckIfUserFirstTimeSuccessState &&
              !state.isUserFirstTime) {
            print('inside');
            context.goNamed(Routes.home);
          } else if (state is CacheUserFirstTimeSuccessState) {
            // TODO(User-Cached-Handler): Redirect the user to the proper page.
          }
        },
        builder: (context, state) {
          if (state is CacheUserFirstTimeLoadingState ||
              state is CheckIfUserFirstTimeLoadingState) {
            return const LoadingPage();
          }

          return ImageBackground(
            image: Media.onBoardingBackground,
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnboardingBody(pageContent: PageContent.first()),
                    OnboardingBody(pageContent: PageContent.second()),
                    OnboardingBody(pageContent: PageContent.third()),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, .04),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: Colours.primaryColour,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
