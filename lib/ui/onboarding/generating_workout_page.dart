import 'package:entrenai/domain/cubit/onboarding/onboarding_cubit.dart';
import 'package:entrenai/domain/entity/workout.dart';
import 'package:entrenai/ui/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneratingWorkoutPage extends StatelessWidget {
  const GeneratingWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) => switch (state) {
              OnboardingSettingParameters() => const SizedBox(),
              OnboardingGenerating() => _generatingWorkoutWidget(context),
              OnboardingGenerated() => _generatedWorkoutPage(context, state.workouts),
              OnboardingError() => _buildErrorWidget(context, state.error),
            },
          ),
        ),
      ),
    );
  }

  Widget _generatingWorkoutWidget(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Generating Workout...',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      );

  Widget _generatedWorkoutPage(BuildContext context, List<Workout> workouts) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your workout is ready!',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'You can choose ${workouts.length} different plans',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: workouts.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(RoutesNames.workoutDetails, arguments: workouts[index]),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.numbers),
                        title: Text('Workout option nº ${index + 1}'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          MaterialButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () => context.read<OnboardingCubit>().generateWorkouts(),
            child: Text('Regenerate Workout'),
          )
        ],
      );

  Widget _buildErrorWidget(BuildContext context, dynamic error) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error generating workout', style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center,),
          const SizedBox(height: 16),
          Text(error.toString()),
          const SizedBox(height: 24),
          MaterialButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () => context.read<OnboardingCubit>().generateWorkouts(),
            child: Text('Retry'),
          )
        ],
      );
}
