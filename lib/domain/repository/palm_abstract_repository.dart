import 'package:entrenai/domain/entity/workout.dart';
import 'package:entrenai/domain/entity/workout_configuration.dart';

abstract class PalmAbstractRepository {
  Future<List<Workout>> getWorkouts(WorkoutConfiguration parameters);
  Future editWorkout(int workoutId, Map<String, dynamic> workoutData);
}
