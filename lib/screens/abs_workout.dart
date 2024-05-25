import 'package:flutter/material.dart';

class AbsWorkoutPage extends StatelessWidget {
  final Function(String) onSelectExercise;

  const AbsWorkoutPage({super.key, required this.onSelectExercise});

  static String id = 'abs_workout_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abs Workout'),
        leading: const BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExerciseTile(context, 'Crunch'),
          _buildExerciseTile(context, 'Sit-up'),
          _buildExerciseTile(context, 'Plank'),
          _buildExerciseTile(context, 'Russian Twist'),
          _buildExerciseTile(context, 'Leg Raise'),
          _buildExerciseTile(context, 'Bicycle Crunch'),
          _buildExerciseTile(context, 'Mountain Climber'),
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
