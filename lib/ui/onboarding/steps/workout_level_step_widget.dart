import 'package:entrenai/domain/cubit/onboarding/onboarding_cubit.dart';
import 'package:entrenai/domain/entity/workout_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutLevelStepWidget extends StatelessWidget {
  const WorkoutLevelStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'How long have you been training?',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) => switch (state) {
                    OnboardingSettingParameters() => Column(
                        children: WorkoutLevelEnum.values
                            .map(
                              (level) => Column(
                                children: [
                                  ChoiceChip.elevated(
                                    label: Text(level.range),
                                    selected: level == state.workoutLevel,
                                    onSelected: (value) => context.read<OnboardingCubit>().setWorkoutLevel(level),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    OnboardingGenerating() || OnboardingGenerated() || OnboardingError() => const SizedBox(),
                  })
        ],
      ),
    );
  }
}
