enum WorkoutGoalEnum {
  loseWeight(
    name: 'Lose weight',
    valueToPrompt:
        'The goal of this workout plan is help the user to lose fat and decrease weight',
  ),
  gainMuscle(
    name: 'Gain muscle mass',
    valueToPrompt: 'The goal of this workout plan is help the user to gain muscle mass',
  ),
  stayFit(
    name: 'Stay fit',
    valueToPrompt: 'The goal of this workout plan is help the user to stay fit',
  );

  const WorkoutGoalEnum({
    required this.name,
    required this.valueToPrompt,
  });

  final String name;
  final String valueToPrompt;
}