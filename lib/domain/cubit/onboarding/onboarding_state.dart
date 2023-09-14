part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingSettingParameters extends OnboardingState {
  final int workoutDays;
  final WorkoutGoalEnum goal;
  final WorkoutLocationEnum location;
  final WorkoutLevelEnum workoutLevel;
  final int age;
  final String sex;

  OnboardingSettingParameters({
    required this.workoutDays,
    required this.goal,
    required this.location,
    required this.workoutLevel,
    required this.age,
    required this.sex,
  });

  OnboardingSettingParameters copyWith({
    int? workoutDays,
    WorkoutGoalEnum? goal,
    WorkoutLocationEnum? location,
    WorkoutLevelEnum? workoutLevel,
    int? age,
    String? sex,
  }) =>
      OnboardingSettingParameters(
        workoutDays: workoutDays ?? this.workoutDays,
        goal: goal ?? this.goal,
        location: location ?? this.location,
        workoutLevel: workoutLevel ?? this.workoutLevel,
        age: age ?? this.age,
        sex: sex ?? this.sex,
      );
}

final class OnboardingGenerating extends OnboardingState {}

final class OnboardingGenerated extends OnboardingState {
  final List<Workout> workouts;

  OnboardingGenerated({required this.workouts});
}

final class OnboardingError extends OnboardingState {
  final dynamic error;

  OnboardingError({required this.error});
}
