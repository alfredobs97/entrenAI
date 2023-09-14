import 'dart:convert';
import 'package:entrenai/domain/ai_examples/prompt_examples.dart';
import 'package:entrenai/domain/entity/workout.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:entrenai/domain/entity/workout_configuration.dart';
import 'package:entrenai/domain/repository/palm_abstract_repository.dart';

class PalmHttpRepository extends PalmAbstractRepository {
  final apiKey = dotenv.env['PALM_API_KEY'];

  @override
  Future editWorkout(int workoutId, Map<String, dynamic> workoutData) {
    // TODO: implement editWorkout
    throw UnimplementedError();
  }

  @override
  Future<List<Workout>> getWorkouts(WorkoutConfiguration parameters) async {
    final url =
        Uri.parse('https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=$apiKey');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.post(url, headers: headers, body: _generateBodyPrompt(parameters));
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        final List<dynamic> candidates = decodedResponse['candidates'];
        final List<Workout> workouts = [];

        for (final candidate in candidates) {
          workouts.add(Workout(content: candidate['output']));
        }

        return workouts;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.\n\n${response.body}');
      }
    } catch (error) {
      throw Exception('Error sending POST request: $error');
    }
  }

  String _generateBodyPrompt(WorkoutConfiguration parameters) => jsonEncode({
        "prompt": {
          "text":
              "Generate a workout plan for a ${parameters.age}-year-old ${parameters.sex} who is ${parameters.workoutLevel.name} in fitness and trains in ${parameters.location.valueToPrompt}. ${parameters.goal.valueToPrompt}. The workout should be simple and should be done ${parameters.workoutDays} days a week.The goal is gaining lean muscle mass and lose fat. Include a link with info about every exercise. Convert the response using markdown format with list, never tables."
        },
        "candidate_count": 3,
        "temperature": 1,
      });
}
