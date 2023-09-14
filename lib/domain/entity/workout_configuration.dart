import 'package:entrenai/domain/entity/workout_goal_enum.dart';
import 'package:entrenai/domain/entity/workout_level.dart';
import 'package:entrenai/domain/entity/workout_location_enum.dart';

class WorkoutConfiguration {
  final int workoutDays;
  final WorkoutGoalEnum goal;
  final WorkoutLocationEnum location;
  final WorkoutLevelEnum workoutLevel;
  final int age;
  final String sex;

  WorkoutConfiguration({
    required this.workoutDays,
    required this.goal,
    required this.location,
    required this.workoutLevel,
    required this.age,
    required this.sex,
  });
}