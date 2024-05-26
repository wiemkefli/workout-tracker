import 'package:flutter/material.dart';
import 'package:workoutamw/screens/active_workout.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  static String id = 'workout_page';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20), // This replaces the "WORKOUT" text space
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ActiveWorkoutPage.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text(
              'START WORKOUT',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
