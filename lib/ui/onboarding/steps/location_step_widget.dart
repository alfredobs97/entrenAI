import 'package:entrenai/domain/cubit/onboarding/onboarding_cubit.dart';
import 'package:entrenai/domain/entity/workout_location_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationStepWidget extends StatelessWidget {
  const LocationStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Where will you train?',
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
                  children: WorkoutLocationEnum.values
                      .map(
                        (location) => Column(
                          children: [
                            ChoiceChip.elevated(
                              label: Text(location.name),
                              selected: location == state.location,
                              onSelected: (value) => context.read<OnboardingCubit>().setLocation(location),
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
