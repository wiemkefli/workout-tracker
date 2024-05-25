import 'package:flutter/material.dart';

class ChestWorkoutPage extends StatelessWidget {
  final Function(String) onSelectExercise;

  const ChestWorkoutPage({super.key, required this.onSelectExercise});

  static String id = 'chest_workout_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chest Workout'),
        leading: const BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExerciseTile(context, 'Bench Press'),
          _buildExerciseTile(context, 'Incline Bench Press'),
          _buildExerciseTile(context, 'Decline Bench Press'),
          _buildExerciseTile(context, 'Chest Fly'),
          _buildExerciseTile(context, 'Push-up'),
          _buildExerciseTile(context, 'Cable Crossover'),
          _buildExerciseTile(context, 'Pec Deck Fly'),
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
