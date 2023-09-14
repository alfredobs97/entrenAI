import 'package:entrenai/domain/cubit/onboarding/onboarding_cubit.dart';
import 'package:entrenai/domain/entity/workout_goal_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalsStepWidget extends StatelessWidget {
  const GoalsStepWidget({super.key});

 @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'What\'s your main goal?',
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
                  children: WorkoutGoalEnum.values
                      .map(
                        (goal) => Column(
                          children: [
                            ChoiceChip.elevated(
                              label: Text(goal.name),
                              selected: goal == state.goal,
                              onSelected: (value) => context.read<OnboardingCubit>().setGoal(goal),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      )
                      .toList()),
              OnboardingGenerating() || OnboardingGenerated() || OnboardingError() => const SizedBox()
            },
          ),
        ],
      ),
    );
  }
}