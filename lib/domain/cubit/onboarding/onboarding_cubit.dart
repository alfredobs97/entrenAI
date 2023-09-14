import 'package:bloc/bloc.dart';
import 'package:entrenai/domain/entity/workout.dart';
import 'package:entrenai/domain/entity/workout_configuration.dart';
import 'package:entrenai/domain/entity/workout_goal_enum.dart';
import 'package:entrenai/domain/entity/workout_level.dart';
import 'package:entrenai/domain/entity/workout_location_enum.dart';
import 'package:entrenai/domain/repository/palm_abstract_repository.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  static final initalState = OnboardingSettingParameters(
    workoutDays: 1,
    goal: WorkoutGoalEnum.gainMuscle,
    location: WorkoutLocationEnum.gym,
    workoutLevel: WorkoutLevelEnum.beginner,
    age: 16,
    sex: 'Male',
  );
  final PalmAbstractRepository _palmAbstractRepository;

  OnboardingCubit(this._palmAbstractRepository) : super(initalState);

  WorkoutConfiguration? _lastSavedConfiguration;

  void setWorkoutDays(int workoutDays) {
    switch (state) {
      case OnboardingSettingParameters():
        final currentState = state as OnboardingSettingParameters;
        emit(currentState.copyWith(workoutDays: workoutDays));
        break;
      default:
    }
  }

  void setGoal(WorkoutGoalEnum goal) {
    switch (state) {
      case OnboardingSettingParameters():
        final currentState = state as OnboardingSettingParameters;
        emit(currentState.copyWith(goal: goal));
        break;
      default:
    }
  }

  void setLocation(WorkoutLocationEnum location) {
    switch (state) {
      case OnboardingSettingParameters():
        final currentState = state as OnboardingSettingParameters;
        emit(currentState.copyWith(location: location));
        break;
      default:
    }
  }

  void setWorkoutLevel(WorkoutLevelEnum workoutLevel) {
    switch (state) {
      case OnboardingSettingParameters():
        final currentState = state as OnboardingSettingParameters;
        emit(currentState.copyWith(workoutLevel: workoutLevel));
        break;
      default:
    }
  }

  setAge(int age) {
    switch (state) {
      case OnboardingSettingParameters():
        final currentState = state as OnboardingSettingParameters;
        emit(currentState.copyWith(age: age));
        break;
      default:
    }
  }

  setSex(String sex) {
    switch (state) {
      case OnboardingSettingParameters():
        final currentState = state as OnboardingSettingParameters;
        emit(currentState.copyWith(sex: sex));
        break;
      default:
    }
  }

  Future<void> generateWorkouts() async {
    try {
      switch (state) {
        case OnboardingSettingParameters():
          final currentState = state as OnboardingSettingParameters;
          emit(OnboardingGenerating());
          _lastSavedConfiguration = WorkoutConfiguration(
            workoutDays: currentState.workoutDays,
            goal: currentState.goal,
            location: currentState.location,
            workoutLevel: currentState.workoutLevel,
            age: currentState.age,
            sex: currentState.sex,
          );
          final List<Workout> workouts = await _palmAbstractRepository.getWorkouts(_lastSavedConfiguration!);
          emit(OnboardingGenerated(workouts: workouts));
          break;
        case OnboardingGenerated():
          emit(OnboardingGenerating());
          final List<Workout> workouts = await _palmAbstractRepository.getWorkouts(_lastSavedConfiguration!);
          emit(OnboardingGenerated(workouts: workouts));
          break;
        case OnboardingError():
          emit(OnboardingGenerating());
          final List<Workout> workouts = await _palmAbstractRepository.getWorkouts(_lastSavedConfiguration!);
          emit(OnboardingGenerated(workouts: workouts));
          break;
        default:
          break;
      }
    } catch (e) {
      emit(OnboardingError(error: e));
    }
  }

  void load() {
    emit(initalState);
  }
}
