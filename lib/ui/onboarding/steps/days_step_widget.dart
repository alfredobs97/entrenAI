import 'package:entrenai/domain/cubit/onboarding/onboarding_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaysStepWidget extends StatefulWidget {
  const DaysStepWidget({super.key});

  @override
  State<DaysStepWidget> createState() => _DaysStepWidgetState();
}

class _DaysStepWidgetState extends State<DaysStepWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'How many days do you want to train?',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) => Column(
              children: [
                SizedBox(
                  width: 350,
                  child: CupertinoSlider(
                    value: switch (state) {
                      OnboardingSettingParameters() => state.workoutDays.toDouble(),
                      OnboardingGenerating() || OnboardingGenerated() || OnboardingError() => 1,
                    },
                    min: 1,
                    max: 7,
                    divisions: 7,
                    onChanged: (value) => context.read<OnboardingCubit>().setWorkoutDays(value.toInt()),
                  ),
                ),
                switch (state) {
                  OnboardingSettingParameters() => Text(
                      '${state.workoutDays} days',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18),
                    ),
                  OnboardingGenerating() || OnboardingGenerated() || OnboardingError() => const SizedBox(),
                },
              ],
            ),
          )
        ],
      ),
    );
  }
}
