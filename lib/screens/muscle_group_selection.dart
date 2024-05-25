import 'package:flutter/material.dart';
import 'package:workoutamw/screens/arm_workout.dart';
import 'package:workoutamw/screens/chest_workout.dart';
import 'package:workoutamw/screens/leg_workout.dart';
import 'package:workoutamw/screens/abs_workout.dart';


class MuscleGroupSelectionPage extends StatelessWidget {
  final Function(String) onSelectExercise;

  const MuscleGroupSelectionPage({super.key, required this.onSelectExercise});

  static String id = 'muscle_group_selection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Muscle Group'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'PLEASE SELECT A MUSCLE GROUP',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildMuscleGroupButton(
                  context,
                  'Arm',
                  Icons.fitness_center,
                  () => Navigator.pushNamed(
                    context,
                    ArmWorkoutPage.id,
                    arguments: onSelectExercise,
                  ),
                ),
                _buildMuscleGroupButton(
                  context,
                  'Chest',
                  Icons.fitness_center,
                  () => Navigator.pushNamed(
                    context,
                    ChestWorkoutPage.id,
                    arguments: onSelectExercise,
                  ),
                ),
                _buildMuscleGroupButton(
                  context,
                  'Leg',
                  Icons.fitness_center,
                  () => Navigator.pushNamed(
                    context,
                    LegWorkoutPage.id,
                    arguments: onSelectExercise,
                  ),
                ),
                _buildMuscleGroupButton(
                  context,
                  'Abs',
                  Icons.fitness_center,
                  () => Navigator.pushNamed(
                    context,
                    AbsWorkoutPage.id,
                    arguments: onSelectExercise,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMuscleGroupButton(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}