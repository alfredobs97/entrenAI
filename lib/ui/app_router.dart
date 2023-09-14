import 'package:entrenai/data/repository/http_repository.dart';
import 'package:entrenai/domain/cubit/onboarding/onboarding_cubit.dart';
import 'package:entrenai/domain/entity/workout.dart';
import 'package:entrenai/ui/onboarding/generating_workout_page.dart';
import 'package:entrenai/ui/onboarding/onboarding_page.dart';
import 'package:entrenai/ui/splash/video_intro_page.dart';
import 'package:entrenai/ui/workout_details/workout_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RoutesNames {
  static const String splash = '/splash';
  static const String home = '/';
  static const String onboarding = '/onboarding';
  static const String generatingWorkout = '$onboarding/generating-workout';
  static const String workoutDetails = '/workout-details';
}

class AppRouter {
  static String getNestedRouteName() {
    return RoutesNames.splash;
  }

  final onboardingCubit = OnboardingCubit(PalmHttpRepository());

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splash:
        return MaterialPageRoute(builder: (_) => const VideoIntroPage());
      case RoutesNames.home:
        return MaterialPageRoute(builder: (_) => Container());
      case RoutesNames.onboarding:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: onboardingCubit..load(),
            child: const OnboardingPage(),
          ),
        );
      case RoutesNames.generatingWorkout:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: onboardingCubit..generateWorkouts(),
                  child: const GeneratingWorkoutPage(),
                ));
      case RoutesNames.workoutDetails:
        final Workout workout =
            settings.arguments is Workout ? (settings.arguments as Workout) : throw StateError('Workout not found');
        return MaterialPageRoute(builder: (_) => WorkoutDetailsPage(workout: workout));
      default:
        throw StateError('Route not found');
    }
  }
}
