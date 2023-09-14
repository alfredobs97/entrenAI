enum WorkoutLocationEnum {
  gym(
    name: 'Gym 🏋️‍♀️',
    valueToPrompt:
        'in a commercial gym, with dumbbells and barbells but with a few machines so the workout has to be simple',
  ),
  home(
    name: 'House 🏠',
    valueToPrompt: 'in home, with only furnitures, no dumbbells, no barbells, no machine exercises',
  ),
  outdoor(
    name: 'Street 🛣',
    valueToPrompt: 'in the street, no barbells, no dumbbells, no machines exercises, only body weight',
  );

  const WorkoutLocationEnum({
    required this.name,
    required this.valueToPrompt,
  });

  final String name;
  final String valueToPrompt;
}
