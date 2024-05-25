import 'package:flutter/material.dart';

class ArmWorkoutPage extends StatelessWidget {
  final Function(String) onSelectExercise;

  const ArmWorkoutPage({super.key, required this.onSelectExercise});

  static String id = 'arm_workout_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arm Workout'),
        leading: const BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExerciseTile(context, 'Dumbbell Curl'),
          _buildExerciseTile(context, 'Hammer Curl'),
          _buildExerciseTile(context, 'Concentration Curl'),
          _buildExerciseTile(context, 'Barbell Curl'),
          _buildExerciseTile(context, 'Preacher Curl'),
          _buildExerciseTile(context, 'Cable Curl'),
          _buildExerciseTile(context, 'Reverse Curl'),
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
