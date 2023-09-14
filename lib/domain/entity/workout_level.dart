enum WorkoutLevelEnum {
  beginner(range: '0 - 6 months'),
  intermediate(range: '6 - 24 months'),
  advanced(range: '+2 years');

  const WorkoutLevelEnum({
    required this.range,
  });

  final String range;
}
