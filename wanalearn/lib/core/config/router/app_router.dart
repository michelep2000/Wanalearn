import 'package:go_router/go_router.dart';
import 'package:wanalearn/core/common/views/under_construction_page.dart';
import 'package:wanalearn/core/config/router/utils/pages.dart';
import 'package:wanalearn/core/config/router/utils/transitions.dart';


final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/jjj',
      pageBuilder: (context, state) => Transitions.fadeTransition(
        state,
        const OnboardingPage(),
      ),
    ),
  ],
  errorBuilder: (_, __) => const UnderConstructionPage(),
);
