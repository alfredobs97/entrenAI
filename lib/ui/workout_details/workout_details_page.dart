import 'package:entrenai/domain/entity/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkoutDetailsPage extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailsPage({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your workout'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MarkdownBody(
              data: workout.content,
              onTapLink: (text, href, title) => _launchUrl(Uri.tryParse(href!)),
              
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri? uri) async {
    if (uri != null && !await launchUrl(uri)) {}
  }
}
