import 'package:dots_indicator/dots_indicator.dart';
import 'package:entrenai/ui/onboarding/steps/days_step_widget.dart';
import 'package:entrenai/ui/onboarding/steps/goals_step_widget.dart';
import 'package:entrenai/ui/onboarding/steps/location_step_widget.dart';
import 'package:entrenai/ui/onboarding/steps/personal_info_step_widget.dart';
import 'package:entrenai/ui/onboarding/steps/workout_level_step_widget.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
   final _pageController = PageController();
  final _steps = [
    const DaysStepWidget(),
    const GoalsStepWidget(),
    const WorkoutLevelStepWidget(),
    const LocationStepWidget(),
    const PersonalInfoStepWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Image.asset('assets/logo.jpeg', height: 140),
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: _steps,
              ),
            ),
            ListenableBuilder(
              listenable: _pageController,
              builder: (context, child) => DotsIndicator(
                dotsCount: _steps.length,
                position: _pageController.page?.toInt() ?? 0,
                decorator: DotsDecorator(
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
                onTap: (position) => _pageController.animateToPage(
                  position.toInt(),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                ),
              ),
            )
          ],
        )),
      ),
      floatingActionButton: ListenableBuilder(
        listenable: _pageController,
        builder: (context, _) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _pageController.page?.toInt() == _steps.length - 1
              ? const SizedBox()
              : FloatingActionButton(
                  onPressed: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  ),
                  tooltip: 'Next page',
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
        ),
      ),
    );
  }
}
