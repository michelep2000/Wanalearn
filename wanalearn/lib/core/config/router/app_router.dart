import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wanalearn/core/common/pages/under_construction_page.dart';
import 'package:wanalearn/core/config/router/utils/export_pages.dart';
import 'package:wanalearn/core/config/router/utils/routes.dart';
import 'package:wanalearn/core/config/router/utils/transitions.dart';
import 'package:wanalearn/core/di/dependency_injection.dart';
import 'package:wanalearn/features/onboarding/presentation/bloc/onboarding_bloc.dart';

final goRouter = GoRouter(
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      path: Routes.onboarding,
      pageBuilder: (context, state) => Transitions.fadeTransition(
        state,
        BlocProvider(
          create: (context) => sl<OnboardingBloc>(),
          child: const OnboardingPage(),
        ),
      ),
    ),

    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) => Transitions.fadeTransition(
        state,
        BlocProvider(
          create: (context) => sl<OnboardingBloc>(),
          child: const OnboardingPage(),
        ),
      ),
    ),
  ],
errorBuilder: (_, __) => const UnderConstructionPage(),
);
