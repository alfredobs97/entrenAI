import 'package:entrenai/domain/cubit/onboarding/onboarding_cubit.dart';
import 'package:entrenai/ui/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInfoStepWidget extends StatefulWidget {
  const PersonalInfoStepWidget({super.key});

  @override
  State<PersonalInfoStepWidget> createState() => _PersonalInfoStepWidgetState();
}

class _PersonalInfoStepWidgetState extends State<PersonalInfoStepWidget> {
  final List<int> _ages = List<int>.generate(42, (int index) => index + 16);
  final List<String> _sexOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'We need some information to create your plan.',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your age'),
              const SizedBox(width: 16),
              BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) => switch (state) {
                  OnboardingSettingParameters() => CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(
                        '${state.age} years',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18),
                      ),
                      onPressed: () => _showDialog(
                        CupertinoPicker(
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 80,
                          scrollController: FixedExtentScrollController(
                            initialItem: state.age,
                          ),
                          onSelectedItemChanged: (int index) {
                            context.read<OnboardingCubit>().setAge(_ages[index]);
                          },
                          children: _ages
                              .map(
                                (index) => Center(
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).pop(),
                                    child: Text('${index}'),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  OnboardingGenerating() || OnboardingGenerated() || OnboardingError() => const SizedBox(),
                },
              )
            ],
          ),
          const Divider(thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Your sex'),
              const SizedBox(width: 16),
              BlocBuilder<OnboardingCubit, OnboardingState>(
                  builder: (context, state) => switch (state) {
                        OnboardingSettingParameters() => CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Text(
                              state.sex,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18),
                            ),
                            onPressed: () => _showDialog(
                              CupertinoPicker(
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  itemExtent: 50,
                                  scrollController: FixedExtentScrollController(
                                    initialItem: 0,
                                  ),
                                  onSelectedItemChanged: (int selectedItem) {
                                    context.read<OnboardingCubit>().setSex(_sexOptions[selectedItem]);
                                  },
                                  children: _sexOptions
                                      .map((sex) => GestureDetector(
                                            onTap: () => Navigator.of(context).pop(),
                                            child: Text(sex),
                                          ))
                                      .toList()),
                            ),
                          ),
                        OnboardingGenerating() || OnboardingGenerated() || OnboardingError() => const SizedBox(),
                      })
            ],
          ),
          const SizedBox(height: 100),
          SizedBox(
            width: 250,
            child: MaterialButton(
                onPressed: () => Navigator.pushReplacementNamed(context, RoutesNames.generatingWorkout),
                color: Theme.of(context).colorScheme.secondary,
                height: 48,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                child: const Text(
                  'Generate your Plan',
                  style: TextStyle(color: Colors.black),
                )),
          ),
        ],
      ),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
