import 'package:flutter/material.dart';

class LegWorkoutPage extends StatelessWidget {
  final Function(String) onSelectExercise;

  const LegWorkoutPage({super.key, required this.onSelectExercise});

  static String id = 'leg_workout_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leg Workout'),
        leading: const BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExerciseTile(context, 'Squat'),
          _buildExerciseTile(context, 'Leg Press'),
          _buildExerciseTile(context, 'Lunge'),
          _buildExerciseTile(context, 'Leg Curl'),
          _buildExerciseTile(context, 'Leg Extension'),
          _buildExerciseTile(context, 'Calf Raise'),
          _buildExerciseTile(context, 'Deadlift'),
        ],
      ),
    );
  }

  Widget _buildExerciseTile(BuildContext context, String exerciseName) {
    return ListTile(
      title: Text(exerciseName),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        onSelectExercise(exerciseName);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}
